//SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import { AutomationCompatibleInterface } from "@chainlink/contracts@1.3.0/src/v0.8/automation/AutomationCompatible.sol";

contract CustomLogicCounter is AutomationCompatibleInterface {
    uint256 public counter;
    uint256 lastTimeCalled;
    uint256 immutable i_timeInterval;

    constructor(uint256 _interval){
        i_timeInterval = _interval;
        lastTimeCalled = block.timestamp;
    }

    function checkUpkeep(  
        bytes calldata /* checkData */  
    )  
        external  
        view  
        override  
        returns (bool upkeepNeeded, bytes memory performData)  
    {  
        upkeepNeeded = (block.timestamp - lastTimeCalled) > i_timeInterval;
        return (upkeepNeeded , "");
    }

    function performUpkeep(bytes calldata) external override { 
        if ((block.timestamp - lastTimeCalled) > i_timeInterval) {
            counter++;
        }
     }
     function getCounter() public view returns(uint256){
        return counter;
     }
}