
import ICOContract from "./contracts/ICO.json";
import getWeb3 from "./getWeb3";
import axios from "axios";


class App extends Component {
  state = { web3: null, accounts: null, contract: null };

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();

      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = ICOContract.networks[networkId];
      const instance = new web3.eth.Contract(
        ICOContract.abi,
        deployedNetwork && deployedNetwork.address,
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      this.setState({ web3, accounts, contract: instance }, this.runExample);
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  whitlist = async () => {
    const { accounts, contract } = this.state;
    await contract.methods.whitelist("address").send({ from: accounts[0] });
  };

  privatesale = async()=>{
  
  resp = await axios({
    url: 'https://api.binance.com/api/v3/ticker/price',
    params: {
      symbol: 'ETHUSDT'
    },
    method: 'get'
  })
  
  ethusd=resp.data.price
  await contract.methods.PrivateSale(ethusd,Date.now()/1000).send({ from: accounts[0] });
};

presale = async()=>{
  
  resp = await axios({
    url: 'https://api.binance.com/api/v3/ticker/price',
    params: {
      symbol: 'ETHUSDT'
    },
    method: 'get'
  })
  
  ethusd=resp.data.price
  await contract.methods.PreSale(ethusd,Date.now()/1000).send({ from: accounts[0] });
};

crowdsale = async()=>{
  
  resp = await axios({
    url: 'https://api.binance.com/api/v3/ticker/price',
    params: {
      symbol: 'ETHUSDT'
    },
    method: 'get'
  })
  
  ethusd=resp.data.price
  await contract.methods.crowdSale(ethusd,Date.now()/1000).send({ from: accounts[0] });
};


}
 
