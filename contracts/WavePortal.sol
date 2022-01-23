// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;

   
    event NewWave(address indexed from, uint256 timestamp, string message);

  
    struct Wave {
        address waver; 
        string message;
        uint256 timestamp;
    }

    Wave[] waves;
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Contract Constructor");
        seed = (block.timestamp + block.difficulty) % 100;
    }
    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Wait 30 seconds before waving again"
        );
        lastWavedAt[msg.sender] = block.timestamp;


        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log('# random generated', seed);

        if(seed <= 50) {
            uint256 prizeMoney = 0.0001 ether;
            require(
                prizeMoney <= address(this).balance,
                "trying to withdraw more money than this contract has"
            );
            (bool success, ) = (msg.sender).call{value: prizeMoney}("");
            require(success, "Failed to withdraw money from contract.");
        }


        emit NewWave(msg.sender, block.timestamp, _message);
    }
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}