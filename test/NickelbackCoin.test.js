const NickelbackCoin = artifacts.require("NickelbackCoin");

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
    const totalSupply = await nbc.totalSupply();
    const creatorBalance = await nbc.balanceOf(creator);
    const initialSupply = await nbc.INITIAL_SUPPLY();

    assert(creatorBalance.eq(initialSupply));
    assert(totalSupply.eq(creatorBalance));
  });

  describe("funding the contract", function() {
    beforeEach(async function() {
      nbc.sendTransaction({
        from: donor,
        value: web3.toWei("0.1", "ether")
      });
    });

    it("does not change user balances", async function() {
      var bigNumber = await nbc["balanceOf"](creator);
      const creatorBalance = await bigNumber.toNumber();
      assert.equal(creatorBalance, 400);

      // bigNumber = await nbc["balanceOf"](user);
      // const userBalance = await bigNumber.toNumber();
      // assert.equal(userBalance, 0);
    });
  });
});
