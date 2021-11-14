// SPDX-License-Identifier: GPL-3.0
pragma solidity^ 0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable{
    
    using SafeMath for uint;
    event AllowanceChanged(address indexed _who,address indexed _from,uint _oldamount,uint _newamount);
    mapping(address=>uint) public allowance;
   
   function addAllowane(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who,msg.sender,allowance[_who],_amount);
       allowance[_who]=_amount;
      
   }
 
  modifier ownerOrAllowed(uint _amount){
     
     require(owner()==msg.sender||allowance[msg.sender]>=_amount);
     _;
 }
 
 function reduceAllowance(address add, uint _amount) internal {
     emit AllowanceChanged(add,msg.sender,allowance[add],allowance[add].sub(_amount));
     
     allowance[add]=allowance[add].sub(_amount);
 }
    
}
