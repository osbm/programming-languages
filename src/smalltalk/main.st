"Collatz Conjecture in Smalltalk"

| collatzLenAndPeak scanUpto |

collatzLenAndPeak := [ :x |
    | steps peak n |
    steps := 0.
    peak := x.
    n := x.
    
    [ n ~= 1 ] whileTrue: [
        n odd ifTrue: [
            n := 3 * n + 1
        ] ifFalse: [
            n := n // 2
        ].
        
        n > peak ifTrue: [ peak := n ].
        steps := steps + 1
    ].
    
    Array with: steps with: peak
].

scanUpto := [ :N |
    | bestN bestSteps bestPeak xorSteps |
    bestN := 1.
    bestSteps := 0.
    bestPeak := 1.
    xorSteps := 0.
    
    1 to: N do: [ :n |
        | result steps peak |
        result := collatzLenAndPeak value: n.
        steps := result at: 1.
        peak := result at: 2.
        xorSteps := xorSteps bitXor: steps.
        steps > bestSteps ifTrue: [
            bestN := n.
            bestSteps := steps.
            bestPeak := peak
        ]
    ].
    
    Array with: bestN with: bestSteps with: bestPeak with: xorSteps
].

"Main execution"
'hello world!' displayNl.

| N result bestN bestSteps bestPeak xorSteps |
N := 1000000.
result := scanUpto value: N.
bestN := result at: 1.
bestSteps := result at: 2.
bestPeak := result at: 3.
xorSteps := result at: 4.

('collatz_longest(1..', N printString, ')') displayNl.
('n*=', bestN printString) displayNl.
('steps=', bestSteps printString) displayNl.
('peak=', bestPeak printString) displayNl.
('xor_steps=', xorSteps printString) displayNl.