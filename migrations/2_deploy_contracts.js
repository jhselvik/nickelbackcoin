module.exports = function(deployer) {
  deployer.deploy(artifacts.require(`./NickelbackCoin.sol`));
};
