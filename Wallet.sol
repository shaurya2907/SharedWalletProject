// SPDX-License-Identifier: GPL-3.0
pragma solidity^ 0.8.1;

import "Allowance.sol";


contract SimpleWallet is Allowance{
    
   event MoneySent(address indexed benif, uint _amount);
   
   event MoneyReceived(address indexed from, uint _amount);
    
    function WithdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(_amount<=address(this).balance,"There are not enough funds stored in the smart contract");
      if(msg.sender!=owner()){
          reduceAllowance(msg.sender,_amount);
      }
      emit  MoneySent(_to,_amount);
        _to.transfer(_amount);
        
        
    }
    
    function renounceOwnership() public override onlyOwner{
        revert("Can't renounce ownership here");
        
    }
    
    receive() external payable{
        emit MoneyReceived(msg.sender,msg.value);
        
    }
    
}
