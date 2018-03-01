pragma solidity ^0.4.18;


import './EthExchangeRate.sol';


contract EthExchangeRateMock is EthExchangeRate {
    uint256 rawOracleValue;

    function ethPriceFromMakerDaoOracle() public view returns (uint256) {
        return rawOracleValue;
    }

    function setNewExchangeRate(uint256 _newRate) public {
        rawOracleValue = _newRate;
    }
}
