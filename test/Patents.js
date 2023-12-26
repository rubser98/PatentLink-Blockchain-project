const Patents = artifacts.require('Patents');
const assert = require('assert');

contract('Patents', (accounts) => {
  const BUYER = accounts[1];
  const PATENT_ID = 0;

  it('should allower a user to buy a patent', async () => {
    const instance = await Patents.deployed();
    const originalPatent = await instance.patents(
      PATENT_ID
    );
    await instance.buyPatent(PATENT_ID, {
      from: BUYER,
      value: originalPatent.price,
    });
    const updatedPatent = await instance.patents(PATENT_ID);
    assert.equal(
      updatedPatent.owner,
      BUYER,
      'the buyer should now own this patent'
    );
  });
});