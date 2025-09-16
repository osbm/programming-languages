\ Collatz Conjecture in Forth

variable best-n
variable best-steps
variable best-peak
variable xor-steps

: collatz-len-and-peak ( n -- steps peak )
  dup        ( n n )
  0 swap     ( n steps n )
  over       ( n steps n peak )
  begin
    dup 1 <>
  while
    dup 1 and if
      3 * 1+
    else
      2 /
    then
    dup 2 pick max  ( n steps n' peak' )
    nip             ( n steps n' peak' )
    -rot 1+ -rot    ( n steps' n' peak' )
  repeat
  nip nip ;         ( steps peak )

: scan-upto ( n -- )
  1 best-n !
  0 best-steps !
  1 best-peak !
  0 xor-steps !
  
  1+ 1 do
    i collatz-len-and-peak  ( steps peak )
    over xor-steps @ xor xor-steps !
    over best-steps @ > if
      i best-n !
      dup best-steps !
      dup best-peak !
    then
    2drop
  loop ;

." hello world!" cr

1000000 scan-upto

." collatz_longest(1..1000000)" cr
." n*=" best-n @ . cr
." steps=" best-steps @ . cr  
." peak=" best-peak @ . cr
." xor_steps=" xor-steps @ . cr

bye