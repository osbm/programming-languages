
local function collatz_len_and_peak (n)
    local steps = 0
    local peak = n
    while n ~= 1 do
        if n % 2 == 0 then
            n = math.floor(n / 2)
        else
            n = 3 * n + 1
        end
        if n > peak then
            peak = n
        end
        steps = steps + 1
    end
    return steps, peak
end

local function scan_upto (N)
    local best_n = 1
    local best_steps = 0
    local best_peak = 1
    local xor_steps = 0

    for n = 1, N do
        local steps, peak = collatz_len_and_peak(n)
        xor_steps = bit32.bxor(xor_steps, steps)
        if steps > best_steps then
            best_n = n
            best_steps = steps
            best_peak = peak
        end
    end

    return best_n, best_steps, best_peak, xor_steps
end

print("hello world!")
local best_n, best_steps, best_peak, xor_steps = scan_upto(1000000)

print("collatz_longest(1..1000000)")
print("n*=" .. best_n)
print("steps=" .. best_steps)
print("peak=" .. best_peak)
print("xor_steps=" .. xor_steps)
