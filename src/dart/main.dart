import 'dart:math';

List<int> collatzLenAndPeak(int x) {
  int steps = 0;
  int peak = x;
  int n = x;

  while (n != 1) {
    if (n & 1 != 0) {
      n = 3 * n + 1;
    } else {
      n >>= 1;
    }

    if (n > peak) {
      peak = n;
    }
    steps++;
  }
  return [steps, peak];
}

List<int> scanUpto(int n) {
  int bestN = 1;
  int bestSteps = 0;
  int bestPeak = 1;
  int xorSteps = 0;

  for (int i = 1; i <= n; i++) {
    List<int> result = collatzLenAndPeak(i);
    int steps = result[0];
    int peak = result[1];
    xorSteps ^= steps;
    if (steps > bestSteps) {
      bestN = i;
      bestSteps = steps;
      bestPeak = peak;
    }
  }

  return [bestN, bestSteps, bestPeak, xorSteps];
}

void main() {
  print('hello world!');

  int n = 1000000;
  List<int> result = scanUpto(n);
  int bestN = result[0];
  int bestSteps = result[1];
  int bestPeak = result[2];
  int xorSteps = result[3];

  print('collatz_longest(1..$n)');
  print('n*=$bestN');
  print('steps=$bestSteps');
  print('peak=$bestPeak');
  print('xor_steps=$xorSteps');
}
