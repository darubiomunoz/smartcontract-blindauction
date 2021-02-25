// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BlindAuction {
    uint public value;
    address payable public seller;
    address payable public buyer;

    enum State { Created, Locked, Release, Inactive }
    State public state;

    modifier condition(bool _condition) {
        require(_condition);
        _;
    }

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only the buyer can call this functionality.");
        _;
    }
    
    modifier onlySeller() {
        require(msg.sender == seller, "Only the seller can call this functionality.");
        _;
    }

    modifier inState(State _state) {
        require(state == _state, "Invalid state.");
        _;
    }

    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();
    event SellerRefunded();

    constructor() payable {
        seller = payable(msg.sender);
        value = msg.value / 2;
        
        require((2 * value) == msg.value, "tThe value has to be even.");
    }
}