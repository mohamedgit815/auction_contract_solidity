// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract AuctionDapp {
    // SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Auctions {

    address public _owner; // Owner Products
    uint256 public _endTime; // End Time in Contract
    uint256 public _minMoney; // Min Money in Auction

    uint256 __value = msg.value;
    address __sender = msg.sender;

    address public _highestBidder; // Top Address  
    uint256 public _highestBid; // Top Address in Money
    

    constructor( uint256 time_ , address owner_ , uint256 minMoney_ ) {
        _owner = owner_;
        _endTime = block.timestamp + time_;
        _minMoney = minMoney_;
    }

    // Function Pay 
    function bid() external payable {

        require( _endTime > block.timestamp , "The Contract Ended" );
        require( __sender != address(0) , "No Address" );
        require( __sender != _owner , "No Address" );
        require( __value > _minMoney , "This is Minimum" );
        require( __value > _highestBid , "This Money is not Enough" );

        

        //payable(_owner).transfer(__value);

        if(_highestBid != 0){
            payable(_highestBidder).transfer(_highestBid);
        }
        
        _highestBid = __value;
        _highestBidder = __sender;


    }


    // Get Money From win in Contract 
    function endAucations() external {
        require( __sender != address(0) && _owner != address(0) , "No Address" );
        require( __sender == _owner , "No Address" );
        require( _endTime <= block.timestamp , "The Acution Eneded" );

        payable(_owner).transfer(_highestBid);

    }
    
    
    // Get Balance in Contract 
    function getBalanceContract() external view returns(uint256) {
        return address(this).balance; 
    }

}
}