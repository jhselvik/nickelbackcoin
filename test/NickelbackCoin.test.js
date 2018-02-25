// request a usable contract abstraction for a specific Solidity contract
const NickelbackCoin = artifacts.require("NickelbackCoin");

// before each contract() function, your contracts are redeployed to the running Ethereum
// client so the tests within it run with a clean contract state
contract("NickelbackCoin", accounts => {
  let nbc;
  const ETH = 1000000000000000000;
  [creator, user, donor] = web3.eth.accounts;

  beforeEach(async function() {
    nbc = await NickelbackCoin.new({ from: creator });
  });

  it("has a name", async function() {
    const name = await nbc.NAME();
    assert.equal(name, "Nickelback Coin");
  });
  it("has a symbol", async function() {
    const symbol = await nbc.SYMBOL();
    assert.equal(symbol, "NBC5");
  });
  it("has 0 decimals", async function() {
    const decimals = await nbc.DECIMALS();
    assert(decimals.eq(0));
  });

  it("assigns the initial total supply to the creator", async function() {
    const initialSupply = await nbc.INITIAL_SUPPLY();
    const creatorBalance = await nbc.balanceOf(creator);
    const totalSupply = await nbc.totalSupply();

    assert(creatorBalance.eq(initialSupply));
    assert(totalSupply.eq(creatorBalance));
  });

  describe("funding the contract", function() {
    beforeEach(async function() {
      // Fails - all sendTransaction's tx exit with error
      await nbc.sendTransaction({
        from: donor,
        value: web3.toWei("0.1", "ether")
      });
    });

    console.log("hello");

    it("does not change user balances", async function() {
      console.log("1");
      let creatorBalance = await nbc["balanceOf"](creator).toNumber();
      assert.equal(creatorBalance, 400);

      console.log("2");
      let userBalance = await nbc["balanceOf"](user).toNumber();
      assert.equal(userBalance, 0);

      console.log("3");
      let donorBalance = await nbc["balanceOf"](donor).toNumber();
      console.log(donorBalance);
    });
  });
});
