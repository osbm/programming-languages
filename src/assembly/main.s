# Collatz Conjecture in x86-64 Assembly (GNU as syntax)
# Equivalent to the Rust/C++ implementation

.section .rodata
hello_msg:
    .string "hello world!\n"
collatz_msg:
    .string "collatz_longest(1..%llu)\n"
nstar_msg:
    .string "n*=%llu\n"
steps_msg:
    .string "steps=%llu\n"
peak_msg:
    .string "peak=%llu\n"
xor_msg:
    .string "xor_steps=%llu\n"

.text
.global main
.extern printf

# Function: collatz_len_and_peak
# Input: rdi = x
# Output: rax = steps, rdx = peak
collatz_len_and_peak:
    movq $0, %rax           # steps = 0
    movq %rdi, %rdx         # peak = x
    movq %rdi, %r8          # n = x

.collatz_loop:
    cmpq $1, %r8            # while (n != 1)
    je .collatz_done

    testq $1, %r8           # check if n is odd
    jz .even

    # odd case: n = 3*n + 1
    leaq (%r8, %r8, 2), %r8 # n *= 3
    addq $1, %r8            # n += 1
    jmp .next_step

.even:
    shrq $1, %r8            # n /= 2

.next_step:
    cmpq %rdx, %r8          # if (n > peak)
    jle .no_peak_update
    movq %r8, %rdx          # peak = n

.no_peak_update:
    addq $1, %rax           # steps++
    jmp .collatz_loop

.collatz_done:
    ret

# Function: scan_upto
# Input: rdi = N
# Output: rax = best_n, rdx = best_steps, rcx = best_peak, r8 = xor_steps
scan_upto:
    pushq %rbp
    movq %rsp, %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15

    movq %rdi, %r15         # N
    movq $1, %r12           # best_n = 1
    movq $0, %r13           # best_steps = 0
    movq $1, %r14           # best_peak = 1
    movq $0, %rbx           # xor_steps = 0
    movq $1, %r11           # n = 1

.scan_loop:
    cmpq %r15, %r11         # n <= N
    jg .scan_done

    # Call collatz_len_and_peak(n)
    movq %r11, %rdi
    call collatz_len_and_peak
    # returns: rax = steps, rdx = peak

    xorq %rax, %rbx         # xor_steps ^= steps

    cmpq %r13, %rax         # if (steps > best_steps)
    jle .next_n

    movq %r11, %r12         # best_n = n
    movq %rax, %r13         # best_steps = steps
    movq %rdx, %r14         # best_peak = peak

.next_n:
    addq $1, %r11           # n++
    jmp .scan_loop

.scan_done:
    # Return values: rax = best_n, rdx = best_steps, rcx = best_peak, r8 = xor_steps
    movq %r12, %rax
    movq %r13, %rdx
    movq %r14, %rcx
    movq %rbx, %r8

    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    ret

main:
    pushq %rbp
    movq %rsp, %rbp

    # Print "hello world!"
    movq $hello_msg, %rdi
    xorq %rax, %rax
    call printf

    # Call scan_upto(1000000)
    movq $1000000, %rdi
    call scan_upto
    # Returns: rax = best_n, rdx = best_steps, rcx = best_peak, r8 = xor_steps

    # Save results
    pushq %rax              # best_n
    pushq %rdx              # best_steps
    pushq %rcx              # best_peak
    pushq %r8               # xor_steps

    # Print "collatz_longest(1..1000000)"
    movq $collatz_msg, %rdi
    movq $1000000, %rsi
    xorq %rax, %rax
    call printf

    # Print "n*=best_n"
    movq $nstar_msg, %rdi
    movq 24(%rsp), %rsi     # best_n
    xorq %rax, %rax
    call printf

    # Print "steps=best_steps"
    movq $steps_msg, %rdi
    movq 16(%rsp), %rsi     # best_steps
    xorq %rax, %rax
    call printf

    # Print "peak=best_peak"
    movq $peak_msg, %rdi
    movq 8(%rsp), %rsi      # best_peak
    xorq %rax, %rax
    call printf

    # Print "xor_steps=xor_steps"
    movq $xor_msg, %rdi
    movq (%rsp), %rsi       # xor_steps
    xorq %rax, %rax
    call printf

    addq $32, %rsp          # Clean up stack

    movq $0, %rax           # return 0
    popq %rbp
    ret
