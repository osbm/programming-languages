program collatz_main
    implicit none
    integer(kind=8) :: n, steps, peak, xor_steps

    write(*,*) 'hello world!'
    write(*,*) 'collatz_longest(1..1000000)'

    call scan_upto(1000000_8, n, steps, peak, xor_steps)

    write(*,'(A,I0)') 'n*=', n
    write(*,'(A,I0)') 'steps=', steps
    write(*,'(A,I0)') 'peak=', peak
    write(*,'(A,I0)') 'xor_steps=', xor_steps
end program collatz_main

subroutine collatz_len_and_peak(n, length, peak)
    implicit none
    integer(kind=8), intent(in) :: n
    integer(kind=8), intent(out) :: length, peak
    integer(kind=8) :: current

    length = 0
    peak = n
    current = n

    do while (current /= 1)
        if (mod(current, 2) == 0) then
            current = current / 2
        else
            current = current * 3 + 1
        end if
        length = length + 1
        if (current > peak) then
            peak = current
        end if
    end do
end subroutine collatz_len_and_peak

subroutine scan_upto(limit, max_n, max_len, max_peak, xor_steps)
    implicit none
    integer(kind=8), intent(in) :: limit
    integer(kind=8), intent(out) :: max_n, max_len, max_peak, xor_steps
    integer(kind=8) :: i, len, peak

    max_len = 0
    max_n = 0
    max_peak = 0
    xor_steps = 0

    do i = 1, limit
        call collatz_len_and_peak(i, len, peak)
        if (len > max_len) then
            max_len = len
            max_n = i
            max_peak = peak
        end if
        xor_steps = ieor(xor_steps, len)
    end do
end subroutine scan_upto
