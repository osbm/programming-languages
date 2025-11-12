// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CollatzConjecture {
    
    function collatzLenAndPeak(uint256 x) internal pure returns (uint256 steps, uint256 peak) {
        steps = 0;
        peak = x;
        uint256 n = x;
        
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
    }
    
    function scanUpto(uint256 N) internal pure returns (uint256 bestN, uint256 bestSteps, uint256 bestPeak, uint256 xorSteps) {
        bestN = 1;
        bestSteps = 0;
        bestPeak = 1;
        xorSteps = 0;
        
        for (uint256 n = 1; n <= N; n++) {
            (uint256 steps, uint256 peak) = collatzLenAndPeak(n);
            xorSteps ^= steps;
            if (steps > bestSteps) {
                bestN = n;
                bestSteps = steps;
                bestPeak = peak;
            }
        }
    }
    
    function run() public pure returns (string memory output) {
        uint256 N = 100000; // Reduced for gas limits
        (uint256 bestN, uint256 bestSteps, uint256 bestPeak, uint256 xorSteps) = scanUpto(N);
        
        return string(abi.encodePacked(
            "hello world!\n",
            "collatz_longest(1..", uint2str(N), ")\n",
            "n*=", uint2str(bestN), "\n",
            "steps=", uint2str(bestSteps), "\n", 
            "peak=", uint2str(bestPeak), "\n",
            "xor_steps=", uint2str(xorSteps)
        ));
    }
    
    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}