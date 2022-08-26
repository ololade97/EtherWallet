// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract EtherWallet {
    address payable public owner;

    address[] public senders;

    mapping(address => uint256) public amountSent;

    uint256 public MinumumEther = 200000000000000000;

    constructor() {
    owner  = payable(msg.sender);
    }


    function withdraw() public payable {
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");

        require(msg.sender == owner, "Only the owner can withdraw.");  
    }

    function send() public payable {
      require(msg.value >= MinumumEther, "send not less than 0.2Eth");

      for(uint senderIndex = 0; senderIndex < senders.length; senderIndex++) {
            address sender = senders[senderIndex];
            amountSent[sender];
        }

        senders = new address[](1);
        senders.push(msg.sender);

        amountSent[msg.sender] = msg.value;

    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    receive() external payable{
        send();
    }

}
