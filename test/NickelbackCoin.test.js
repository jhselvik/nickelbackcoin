const NickelbackCoin = artifacts.require("NickelbackCoin");

contract("NickelbackCoin", accounts => {
  let coin;
  const creator = accounts[0];

  beforeEach(async function() {
    coin = await NickelbackCoin.new({ from: creator });
  });

  it("has a name", async function() {
    const name = await coin.NAME();
    assert.equal(name, "Nickelback Coin");
  });
  it("has a symbol", async function() {
    const symbol = await coin.SYMBOL();
    assert.equal(symbol, "NBC5");
  });
  it("has 0 decimals", async function() {
    const decimals = await coin.DECIMALS();
    assert(decimals.eq(0));
  });

  it("assigns the initial total supply to the creator", async function() {
    const totalSupply = await coin.totalSupply();
    const creatorBalance = await coin.balanceOf(creator);
    const initialSupply = await coin.INITIAL_SUPPLY();

    assert(creatorBalance.eq(initialSupply));
    assert(totalSupply.eq(creatorBalance));
  });
});
