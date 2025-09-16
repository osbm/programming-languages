program CollatzConjecture;

type
  TCollatzResult = record
    steps: Int64;
    peak: Int64;
  end;

function CollatzLenAndPeak(x: Int64): TCollatzResult;
var
  steps, peak, n: Int64;
begin
  steps := 0;
  peak := x;
  n := x;
  
  while n <> 1 do
  begin
    if (n and 1) <> 0 then
      n := 3 * n + 1
    else
      n := n shr 1;
    
    if n > peak then
      peak := n;
    
    Inc(steps);
  end;
  
  CollatzLenAndPeak.steps := steps;
  CollatzLenAndPeak.peak := peak;
end;

procedure ScanUpto(N: Int64; var bestN, bestSteps, bestPeak, xorSteps: Int64);
var
  n: Int64;
  result: TCollatzResult;
begin
  bestN := 1;
  bestSteps := 0;
  bestPeak := 1;
  xorSteps := 0;
  
  for n := 1 to N do
  begin
    result := CollatzLenAndPeak(n);
    xorSteps := xorSteps xor result.steps;
    if result.steps > bestSteps then
    begin
      bestN := n;
      bestSteps := result.steps;
      bestPeak := result.peak;
    end;
  end;
end;

var
  N, bestN, bestSteps, bestPeak, xorSteps: Int64;

begin
  WriteLn('hello world!');
  
  N := 1000000;
  ScanUpto(N, bestN, bestSteps, bestPeak, xorSteps);
  
  WriteLn('collatz_longest(1..', N, ')');
  WriteLn('n*=', bestN);
  WriteLn('steps=', bestSteps);
  WriteLn('peak=', bestPeak);
  WriteLn('xor_steps=', xorSteps);
end.