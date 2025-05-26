# Simple Proof-of-Work Blockchain in Solidity

This smart contract implements a basic on-chain blockchain using Proof of Work (PoW), fully written in Solidity. It simulates block mining by iterating over nonces until a valid hash is found that meets the specified difficulty requirement.

## Features

- Implements a simple blockchain entirely on-chain.
- Genesis block creation.
- On-chain mining with a configurable PoW difficulty.
- Stores each block with:
  - `index`: Position in the chain
  - `previousHash`: Hash of the previous block
  - `timestamp`: Time of creation
  - `data`: Arbitrary user data
  - `nonce`: PoW value
  - `hash`: Final computed hash

## Contract Functions

### `mineBlock(string memory _data)`
Mines a new block containing the `_data` string. The function finds a nonce such that the resulting hash has a number of leading zero bytes as defined by `difficulty`.

> **Note:**  
> Mining is performed entirely on-chain. If mining takes too long or runs out of gas, **reduce the `difficulty` value to `1` or `0`** to make it easier to find a valid hash.

---

### `getLatestBlock()`
Returns the latest block in the blockchain.

### `getChainLength()`
Returns the current number of blocks in the blockchain.

---

## Example Usage (in Remix)

1. Deploy the contract.
2. Call `mineBlock("My First Data")`.
3. If you get an **out of gas** error:
   - Reduce the `difficulty` value from `0` to `0` (it’s already low, but you can adjust it before mining future blocks).
   - Alternatively, increase the **gas limit** manually in Remix.

## Important Notes

- This is a conceptual and educational contract. On-chain PoW is computationally expensive and not recommended for production.
- High difficulty levels may lead to **out-of-gas errors** due to infinite loops in mining.
- Difficulty is set low to make testing practical in development environments like Remix.

---
