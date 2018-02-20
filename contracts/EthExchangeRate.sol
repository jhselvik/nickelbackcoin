pragma solidity ^0.4.18;


import '../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol';


contract Medianizer {
    function compute() public constant returns (bytes32, bool);
}

/**
 * @title Eth exchange rate
 * @notice Taken from mplewis's https://github.com/mplewis/leweycoin
 * @dev Use Maker's Medianizer oracle for an external reference price of eth to usd
 */
contract EthExchangeRate {
    using SafeMath for uint;

    uint weiPerEth = 1000000000000000000;

    function ethPriceFromMakerDaoOracle() public view returns (uint) {
        address makerDaoEthPriceFeedAddress = 0x729D19f657BD0614b4985Cf1D82531c67569197B;
        Medianizer makerDaoEthPriceFeed = Medianizer(makerDaoEthPriceFeedAddress);

        bytes32 rawOracleValue;
        bool feedValid;
        (rawOracleValue,feedValid) = makerDaoEthPriceFeed.compute();
        require(feedValid);

        return uint(rawOracleValue);
    }
}
