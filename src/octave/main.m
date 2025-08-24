function [len, peak] = collatz_len_and_peak(n)
    len = 0;
    peak = n;

    while n != 1
        if mod(n, 2) == 0
            n = n / 2;
        else
            n = 3 * n + 1;
        end

        len = len + 1;
        if n > peak
            peak = n;
        end
    end
end

function [n, steps, peak, xor_steps] = scan_upto(limit)
    n = 1;
    steps = 0;
    peak = 1;
    xor_steps = 0;

    for i = 1:limit
        [current_len, current_peak] = collatz_len_and_peak(i);

        if current_len > steps
            n = i;
            steps = current_len;
            peak = current_peak;
        end

        xor_steps = bitxor(xor_steps, current_len);
    end
end

function main()
    disp('hello world!');
    disp('collatz_longest(1..10000)');

    [n, steps, peak, xor_steps] = scan_upto(10000);

    fprintf('n*=%d\n', n);
    fprintf('steps=%d\n', steps);
    fprintf('peak=%d\n', peak);
    fprintf('xor_steps=%d\n', xor_steps);
end

main();
