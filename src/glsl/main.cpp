#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>

const std::string computeShaderSource = R"(
#version 430
#extension GL_ARB_gpu_shader_int64 : enable

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430, binding = 0) buffer ResultBuffer {
    uint64_t results[];
};

layout(std430, binding = 1) buffer PeakBuffer {
    uint64_t peaks[];
};

uint64_t collatz_len_and_peak(uint64_t x, out uint64_t peak) {
    uint64_t steps = 0ul;
    peak = x;
    uint64_t n = x;

    while (n != 1ul) {
        if ((n & 1ul) != 0ul) {
            n = 3ul * n + 1ul;
        } else {
            n = n >> 1ul;
        }

        if (n > peak) {
            peak = n;
        }
        steps++;
    }
    return steps;
}

void main() {
    uint index = gl_GlobalInvocationID.x;

    // Skip if out of bounds - use exact N instead of results.length()
    if (index >= 1000000u) {
        return;
    }

    uint64_t n = uint64_t(index + 1u);
    uint64_t peak;
    uint64_t steps = collatz_len_and_peak(n, peak);

    results[index] = steps;
    peaks[index] = peak;
}
)";GLuint createComputeShader(const std::string& source) {
    GLuint shader = glCreateShader(GL_COMPUTE_SHADER);
    const char* src = source.c_str();
    glShaderSource(shader, 1, &src, nullptr);
    glCompileShader(shader);

    GLint success;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        GLchar infoLog[512];
        glGetShaderInfoLog(shader, 512, nullptr, infoLog);
        std::cerr << "Compute shader compilation failed:\n" << infoLog << std::endl;
        exit(1);
    }

    return shader;
}

GLuint createComputeProgram(GLuint shader) {
    GLuint program = glCreateProgram();
    glAttachShader(program, shader);
    glLinkProgram(program);

    GLint success;
    glGetProgramiv(program, GL_LINK_STATUS, &success);
    if (!success) {
        GLchar infoLog[512];
        glGetProgramInfoLog(program, 512, nullptr, infoLog);
        std::cerr << "Program linking failed:\n" << infoLog << std::endl;
        exit(1);
    }

    return program;
}

int main() {
    std::cout << "hello world!" << std::endl;

    // Initialize GLFW
    if (!glfwInit()) {
        std::cerr << "Failed to initialize GLFW" << std::endl;
        return -1;
    }

    // Create a hidden window for compute context
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_VISIBLE, GLFW_FALSE);

    GLFWwindow* window = glfwCreateWindow(1, 1, "Compute", nullptr, nullptr);
    if (!window) {
        std::cerr << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(window);

    // Initialize GLEW
    if (glewInit() != GLEW_OK) {
        std::cerr << "Failed to initialize GLEW" << std::endl;
        return -1;
    }

    // Load and compile compute shader
    GLuint computeShader = createComputeShader(computeShaderSource);
    GLuint computeProgram = createComputeProgram(computeShader);

    const uint32_t N = 1000000;

    // Create buffers
    std::vector<uint64_t> results(N, 0);  // Initialize to zero
    std::vector<uint64_t> peaks(N, 0);    // Initialize to zero

    GLuint resultBuffer, peakBuffer;
    glGenBuffers(1, &resultBuffer);
    glGenBuffers(1, &peakBuffer);

    // Allocate and bind result buffer
    glBindBuffer(GL_SHADER_STORAGE_BUFFER, resultBuffer);
    glBufferData(GL_SHADER_STORAGE_BUFFER, N * sizeof(uint64_t), results.data(), GL_DYNAMIC_READ);
    glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 0, resultBuffer);

    // Allocate and bind peak buffer
    glBindBuffer(GL_SHADER_STORAGE_BUFFER, peakBuffer);
    glBufferData(GL_SHADER_STORAGE_BUFFER, N * sizeof(uint64_t), peaks.data(), GL_DYNAMIC_READ);
    glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 1, peakBuffer);    // Dispatch compute shader
    glUseProgram(computeProgram);
    uint32_t workGroups = (N + 63) / 64;  // Round up to nearest multiple of 64
    glDispatchCompute(workGroups, 1, 1);

    // Wait for completion
    glMemoryBarrier(GL_SHADER_STORAGE_BARRIER_BIT);

    // Read back results
    glBindBuffer(GL_SHADER_STORAGE_BUFFER, resultBuffer);
    uint64_t* resultData = (uint64_t*)glMapBuffer(GL_SHADER_STORAGE_BUFFER, GL_READ_ONLY);
    if (resultData) {
        std::copy(resultData, resultData + N, results.begin());
        glUnmapBuffer(GL_SHADER_STORAGE_BUFFER);
    }

    glBindBuffer(GL_SHADER_STORAGE_BUFFER, peakBuffer);
    uint64_t* peakData = (uint64_t*)glMapBuffer(GL_SHADER_STORAGE_BUFFER, GL_READ_ONLY);
    if (peakData) {
        std::copy(peakData, peakData + N, peaks.begin());
        glUnmapBuffer(GL_SHADER_STORAGE_BUFFER);
    }

    // Find the best result
    uint64_t best_n = 1;
    uint64_t best_steps = 0;
    uint64_t best_peak = 1;
    uint64_t xor_steps = 0;

    for (uint32_t i = 0; i < N; i++) {
        uint64_t steps = results[i];
        uint64_t peak = peaks[i];
        uint64_t n = i + 1;

        xor_steps ^= steps;
        if (steps > best_steps) {
            best_n = n;
            best_steps = steps;
            best_peak = peak;
        }
    }    std::cout << "collatz_longest(1.." << N << ")" << std::endl;
    std::cout << "n*=" << best_n << std::endl;
    std::cout << "steps=" << best_steps << std::endl;
    std::cout << "peak=" << best_peak << std::endl;
    std::cout << "xor_steps=" << xor_steps << std::endl;

    // Cleanup
    glDeleteBuffers(1, &resultBuffer);
    glDeleteBuffers(1, &peakBuffer);
    glDeleteProgram(computeProgram);
    glDeleteShader(computeShader);

    glfwDestroyWindow(window);
    glfwTerminate();

    return 0;
}
