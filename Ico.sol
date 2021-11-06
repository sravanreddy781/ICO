// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title Owner
 * @dev Set & change owner
 */
contract ICO is ERC20 {
    
    address payable admin;
    uint  total_tokens= 5* (10**10);
    uint softcap= 5*(10**6);
    uint private_sale_duration = block.timestamp + 15 days;
    uint presale_duration = private_sale_duration + 15 days;
    uint crowdsale_duration = presale_duration + 30 days;
    mapping(address => bool) whitelist_;
    address payable [] investors; 
    mapping(address => uint )  payments;
    uint total_amount;
    uint PrivateSale_bonus = 75;
    uint PreSale_bonus = 80;
    uint crowd_1= 85;
    uint crowd_2 =90;
    uint crowd_3 = 95;
    uint count;
    
    constructor() ERC20("xtoken","x"){
        
      admin=payable(msg.sender) ;
      _mint(0x617F2E2fD72FD9D5503197092aC168c91465E7f2,(30* total_tokens)/100);
      _mint(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, (20*total_tokens)/100);
      _mint(0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c, (10* total_tokens)/100);
      _mint(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db, (13* total_tokens)/100);
      _mint(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB, (2 *total_tokens)/100);
       _mint(msg.sender, (25 *total_tokens)/100);
      
    }
    
     function decimals() public view virtual override returns (uint8) {
        return 0;
    }
    
    function whitelist(address payable investor) public{
        require(msg.sender==admin);
        whitelist_[payable(investor)]=true;
        investors.push(payable(investor));
        approve(investor,total_tokens);
    }
    
    modifier Private_Sale(uint curr_time , uint ethusd){
        require(whitelist_[msg.sender]==true && (msg.value * ethusd)/(10**18) >=500 && curr_time <= private_sale_duration) ;
        _;
    }
    
    function PrivateSale(uint ethusd , uint curr_time ) public payable Private_Sale(curr_time , ethusd){
        total_amount += (msg.value * ethusd)/(10**18) ;
        
        payments[msg.sender]= (msg.value * ethusd);
        
        transferFrom(admin,msg.sender,(payments[msg.sender]/(10**13))/PrivateSale_bonus);
        admin.transfer(msg.value);
        
    }
    
     modifier Pre_Sale(uint curr_time , uint ethusd){
        require(whitelist_[msg.sender]==true &&  (msg.value * ethusd)/(10**18) >=500 && curr_time >= private_sale_duration && curr_time<= presale_duration) ;
        _;
    }
    
    function PreSale(uint ethusd , uint curr_time ) public payable Pre_Sale(curr_time , ethusd){
        total_amount += (msg.value * ethusd)/(10**18);
        payments[msg.sender]= (msg.value * ethusd);
        
        transferFrom(admin,msg.sender,(payments[msg.sender]/(10**13))/PreSale_bonus);
        admin.transfer(msg.value);
        
    }
    
     modifier crowd_Sale(uint curr_time , uint ethusd){
        require(whitelist_[msg.sender]==true &&  (msg.value * ethusd)/(10**18) >=500 && curr_time >= presale_duration && curr_time<= crowdsale_duration) ;
        _;
    }
    
    function crowdSale(uint ethusd , uint curr_time ) public payable crowd_Sale(curr_time , ethusd){
    
        
        if (curr_time <= presale_duration + 7 days){
         total_amount += (msg.value * ethusd)/(10**18);
        payments[msg.sender]= (msg.value * ethusd);
        
        transferFrom(admin,msg.sender,(payments[msg.sender]/(10**13))/crowd_1);
        admin.transfer(msg.value);
        }
        
         if (curr_time > presale_duration + 7 days && curr_time <= presale_duration + 14 days){
         total_amount += (msg.value * ethusd)/(10**18);
        payments[msg.sender]= (msg.value * ethusd);
        transferFrom(admin,msg.sender,(payments[msg.sender]/(10**13))/crowd_2);
        admin.transfer(msg.value);
        }
        
        
         if (curr_time > presale_duration + 14 days && curr_time <= presale_duration + 21 days){
        total_amount += (msg.value * ethusd)/(10**18);
        payments[msg.sender]= (msg.value * ethusd);
        
        transferFrom(admin.msg.sender,(payments[msg.sender]/(10**13))/crowd_3);
        admin.transfer(msg.value);
        }
        
        
         if (curr_time > presale_duration + 21 days && curr_time <= presale_duration + 28 days){
        total_amount += (msg.value * ethusd)/(10**18);
        payments[msg.sender]= (msg.value * ethusd);
        
        transferFrom(admin,msg.sender,(payments[msg.sender]/(10**15)));
        admin.transfer(msg.value);
        
        }
        
        if(total_amount <= softcap){
            for(uint i =0 ;i < investors.length ; i++){
                investors[i].transfer(payments[investors[i]]/ethusd);
            }
        }
    }
}
