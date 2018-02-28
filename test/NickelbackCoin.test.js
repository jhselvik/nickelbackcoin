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
    // don't need to use .call when a function is marked as constant
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

  describe("minting initial tokens", function() {
    beforeEach(async function() {
      // call(creator, 400) returns bool, but no event or value
      // if the function being executed in the transaction has a return value,
      // you will not get that return value inside this result. You must instead
      // use an event and look up the result in the logs array.
      let success = await nbc.mint(creator, 400); // returns tx, not value.
      console.log(success);
    });

    it("creator has minted tokens", async function() {
      // call balanceOf() without creating a transaction by explicitly using .call
      // use for getters, setters will want a tx
      // await nbc["balanceOf"](creator); also seems to work
      let creatorBigNumber = await nbc.balanceOf.call(creator);
      let creatorBalance = await creatorBigNumber.toNumber();
      assert.equal(creatorBalance, 400);
    });
  });

  describe("buy tokens", function() {
    beforeEach(async function() {
      await nbc.buyNickelbackToken({
        from: user,
        value: web3.toWei(0.5, "ether")
      });
    });

    it("user has nbc", async function() {
      let userBigNumber = await nbc.balanceOf.call(user);
      let userBalance = await userBigNumber.toNumber();
      console.log(userBalance);
    });
  });
});
