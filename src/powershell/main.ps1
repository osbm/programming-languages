# Collatz conjecture implementation in PowerShell

function Get-CollatzLenAndPeak {
    param([int64]$n)

    $length = 0
    $peak = $n
    $current = $n

    while ($current -ne 1) {
        if ($current % 2 -eq 0) {
            $current = $current / 2
        } else {
            $current = $current * 3 + 1
        }
        $length++
        if ($current -gt $peak) {
            $peak = $current
        }
    }

    return @($length, $peak)
}

function Get-ScanUpTo {
    param([int]$limit)

    $maxLen = 0
    $maxN = 0
    $maxPeak = 0
    $xorSteps = 0

    for ($i = 1; $i -le $limit; $i++) {
        $result = Get-CollatzLenAndPeak $i
        $len = $result[0]
        $peak = $result[1]

        if ($len -gt $maxLen) {
            $maxLen = $len
            $maxN = $i
            $maxPeak = $peak
        }

        $xorSteps = $xorSteps -bxor $len
    }

    return @($maxN, $maxLen, $maxPeak, $xorSteps)
}

# Main program
Write-Host "hello world!"
Write-Host "collatz_longest(1..1000000)"

$result = Get-ScanUpTo 1000000

Write-Host "n*=$($result[0])"
Write-Host "steps=$($result[1])"
Write-Host "peak=$($result[2])"
Write-Host "xor_steps=$($result[3])"
