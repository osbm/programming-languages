function collatz_len_and_peak(n::Int)
    steps = 0
    peak = n
    while n != 1
        if n % 2 == 0
            n = n ÷ 2
        else
            n = 3 * n + 1
        end
        steps += 1
        if n > peak
            peak = n
        end
    end
    return (steps, peak)
end

function scan_upto(limit::Int)
    longest_n = 1
    longest_steps = 0
    longest_peak = 1

    for i in 1:limit
        (steps, peak) = collatz_len_and_peak(i)
        if steps > longest_steps
            longest_n = i
            longest_steps = steps
            longest_peak = peak
        end
    end

    return (longest_n, longest_steps, longest_peak)
end

function main()
    println("hello world!")
    println("collatz_longest(1..1000000)")

    (n, steps, peak) = scan_upto(1000000)

    println("n*=$n")
    println("steps=$steps")
    println("peak=$peak")

    # Calculate XOR of all steps
    xor_steps = 0
    for i in 1:1000000
        (s, _) = collatz_len_and_peak(i)
        xor_steps ⊻= s
    end
    println("xor_steps=$xor_steps")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
