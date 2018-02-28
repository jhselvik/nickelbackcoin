pragma solidity ^0.4.18;


import '../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol';
import '../node_modules/zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';
import './EthExchangeRate.sol';


/**
 * @title Nickelback Coin
 * @dev An ERC20 Token, all tokens are pre-assigned to the creator. Note they can later
 * distribute these tokens as they wish using `transfer` and other `StandardToken` functions.
 */
contract NickelbackCoin is Ownable, MintableToken, EthExchangeRate {
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
    */
    function totalSupply() public view returns (uint256) {
        return totalSupply;
    }

    // start
    function buyNickelbackToken() public payable returns (uint256) {
        uint256 weiAmount = msg.value;
        uint usdToEth = ethPriceFromMakerDaoOracle();

        uint nbc5 = weiAmount*usdToEth*(20/1);

        balances[msg.sender] = nbc5;

        return nbc5;
    }

    // function sellNickelbackToken(_amount uint256)

}
