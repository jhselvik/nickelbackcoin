pragma solidity ^0.4.18;


import '../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol';


contract Medianizer {
    function compute() public constant returns (bytes32, bool);
}

/**
 * @title Eth exchange rate
 * @notice Taken from mplewis's https://github.com/mplewis/leweycoin
 * @dev Use Maker's Medianizer oracle for an external reference price of eth to usd
 * found at https://developer.makerdao.com/feeds/
 */
contract EthExchangeRate {
    using SafeMath for uint;

    uint weiPerEth = 1000000000000000000;

    /**
     * @notice Receives Eth price from oracle contract
     * @dev Sends a message to the MakerDao contract, mock for testing
     * @return a uint for exchange rate
     */
    function ethPriceFromMakerDaoOracle() public view returns (uint) {
        address makerDaoEthPriceFeedAddress = 0x729D19f657BD0614b4985Cf1D82531c67569197B;
        Medianizer makerDaoEthPriceFeed = Medianizer(makerDaoEthPriceFeedAddress);

        bytes32 rawOracleValue;
        bool feedValid;
        (rawOracleValue,feedValid) = makerDaoEthPriceFeed.compute();
        require(feedValid);

        return uint(rawOracleValue);
    }

    /**
     * @notice Converts USD to Wei with exchange rate from the Maker Dao
     * @param _usd USD to convert to Wei
     * @return a uint for Wei and a bool for if successful
     */
    function usdToWei(uint _usd) public view returns (uint, bool) {
        uint ethPriceInUsdTimesWei = ethPriceFromMakerDaoOracle();
        if (ethPriceInUsdTimesWei == 0) {
            return(0, false);
        }

        uint result = _usd.mul(weiPerEth).mul(weiPerEth).div(ethPriceInUsdTimesWei);
        return (result, true);
    }
}
