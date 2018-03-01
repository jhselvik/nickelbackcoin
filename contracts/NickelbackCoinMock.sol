pragma solidity ^0.4.18;


import './NickelbackCoin.sol';
import './EthExchangeRateMock.sol';


contract NickelbackCoinMock is NickelbackCoin, EthExchangeRateMock {}
