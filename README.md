# ICO

Tokens :

•	mined 50,000,000,000 ERC20 tokens  
•	Divided among six different addresses 

converting ETH to USD :

•	used Binance API to get the latest price 

Bonus structure:

•	for example, a private sale bonus is 25% so the investor has to pay 75%of token costs for each token. These many(75/100 * 0.001 * eth paid * ethusd) number of tokens will be transferred to the investor
•	The eth will be transferred immediately from the contract to the owner

Timeline:

•	In every round, the javascript will send the current time which will be compared with Block.timestamp()

whitelist:

•	used a mapper to map a bool to the investor address(mapping (address=>bool)) 
•	only admin can set the bool value

soft cap:

•	each payment is stored in a mapper variable (address=>uint)
•	if the total amount collected is less than the soft cap collected eth will we transfer back to their accounts 

