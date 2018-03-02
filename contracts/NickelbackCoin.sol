pragma solidity ^0.4.18;


import '../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol';
import '../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol';
import '../node_modules/zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';
import './EthExchangeRate.sol';


/**
 * @title Nickelback Coin
 * @dev An ERC20 Token, all tokens are pre-assigned to the creator. Note they can later
 * distribute these tokens as they wish using `transfer` and other `StandardToken` functions.
 */
contract NickelbackCoin is Ownable, MintableToken, EthExchangeRate {
    using SafeMath for uint;

    string public constant NAME = "Nickelback Coin";
    string public constant SYMBOL = "NBC5";
    uint8 public constant DECIMALS = 0; // Not divisible
    uint256 public constant INITIAL_SUPPLY = 0;

    uint256 public totalSupply;

    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
    * @dev Constructor which starts contract with 0 nbc5 coins
    */
    function NickelbackCoin() public {
        totalSupply = INITIAL_SUPPLY;
    }

    /**
    * @dev total number of tokens in existence
    * @return a uint for total existing Nickelback Coins
    */
    function totalSupply() public view returns (uint256) {
        return totalSupply;
    }

    /**
     * @notice For current usd to eth rate, get a coin for each 5 cents of eth
     * @return a uint for number of Nickelback Coins purchased
     */
    function buyNickelbackToken() public payable returns (uint256) {
        require(msg.value > 0);

        uint256 weiAmount = msg.value;
        uint256 ethAmount = weiAmount.div(1 ether);

        uint256 ethPriceInUsdTimesWei = ethPriceFromMakerDaoOracle();
        uint256 nbc5Amount = ethAmount.mul(ethPriceInUsdTimesWei).mul(20);

        balances[msg.sender] = nbc5Amount;

        return nbc5Amount;
    }

    // function sellNickelbackToken(uint256 _amount) public {
    //     require(_amount >= balances[msg.sender]);

    //     uint ethPriceInUsdTimesWei = ethPriceFromMakerDaoOracle();
    //     uint weiToReceive = _amount.div(20).div(ethPriceInUsdTimesWei)


    // }

}
