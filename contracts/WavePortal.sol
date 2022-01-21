// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address public lastSender;
    constructor() {
        console.log("smart contract constructor");
    }

    function wave() public {
        totalWaves += 1;
        console.log('last sender was', lastSender);
        lastSender = msg.sender;
        console.log('%s has waved!!', msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log('We have %d total waves!', totalWaves);
        return totalWaves;
    }
}

