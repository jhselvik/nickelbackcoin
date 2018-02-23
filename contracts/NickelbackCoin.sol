pragma solidity ^0.4.18;


import '../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol';
import '../node_modules/zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';
import './EthExchangeRate.sol';


/**
 * @title Nickelback Coin
 * @dev An ERC20 Token, all tokens are pre-assigned to the creator. Note they can later
 * distribute these tokens as they wish using `transfer` and other `StandardToken` functions.
 */
contract NickelbackCoin is Ownable, StandardToken, EthExchangeRate {
    string public constant NAME = "Nickelback Coin";
    string public constant SYMBOL = "NBC5";
    uint8 public constant DECIMALS = 0; // Not divisible

    uint256 public constant INITIAL_SUPPLY = 400; // $20 worth

    uint256 public totalSupply;
    mapping(address => uint256) balances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
    * @dev Constructor that gives msg.sender all of existing tokens.
    */
    function NickelbackCoin() public {
        totalSupply = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        Transfer(0x0, msg.sender, INITIAL_SUPPLY);
    }

    /**
    * @dev total number of tokens in existence
    */
    function totalSupply() public view returns (uint256) {
        return totalSupply;
    }

    /**
    * @dev Gets the balance of the specified address.
    * @param _owner The address to query the the balance of.
    * @return An uint256 representing the amount owned by the passed address.
    */
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    /**
    * @dev transfer token for a specified address
    * @param _to The address to transfer to.
    * @param _value The amount to be transferred.
    */
    function transfer(address _to, uint256 _value) public returns (bool) {
        // avoid sending tokens to the 0x0 address, and sender has enough tokens
        require(_to != address(0));
        require(_value <= balances[msg.sender]);

        Transfer(msg.sender, _to, _value);

        return true;
    }

    /**
     * @notice returns balance of address's NBC5
     * @dev use for testing
     */
    function balanceFor(address _recipient) public view returns(uint) {
        return balances[_recipient];
    }

    /**
    * @notice Wihdraw NBC5 from account
    */
    function withdraw() public {
        address recipient = msg.sender;
        uint coinsToWithdraw = balances[recipient];

        // require(coinsToWithdraw != 0);

        uint weiToPayout;
        bool success;
        (weiToPayout, success) = usdToWei(coinsToWithdraw);
        require(success);
        require(this.balance >= weiToPayout);

        balances[recipient] = 0;
        recipient.transfer(weiToPayout);
    }
}
