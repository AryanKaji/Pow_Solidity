// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimplePoWBlockchain {
    struct Block {
        uint index;
        bytes32 previousHash;
        uint timestamp;
        string data;
        uint nonce;
        bytes32 hash;
    }

    Block[] public blockchain;
    uint public difficulty = 2; // 2 leading 0x00 bytes in hash (low to make on-chain mining feasible)

    constructor() {
        _createGenesisBlock();
    }

    function _createGenesisBlock() internal {
        Block memory genesis = Block({
            index: 0,
            previousHash: bytes32(0),
            timestamp: block.timestamp,
            data: "Genesis Block",
            nonce: 0,
            hash: bytes32(0)
        });

        genesis.hash = calculateHash(genesis);
        blockchain.push(genesis);
    }

    function mineBlock(string memory _data) public {
        Block memory previousBlock = blockchain[blockchain.length - 1];
        uint nonce = 0;
        bytes32 hash;

        while (true) {
            hash = calculateHashWithNonce(
                previousBlock.index + 1,
                previousBlock.hash,
                block.timestamp,
                _data,
                nonce
            );

            if (isValidHash(hash)) {
                break;
            }
            nonce++;
        }

        Block memory newBlock = Block({
            index: previousBlock.index + 1,
            previousHash: previousBlock.hash,
            timestamp: block.timestamp,
            data: _data,
            nonce: nonce,
            hash: hash
        });

        blockchain.push(newBlock);
    }

    function calculateHash(Block memory _block) internal pure returns (bytes32) {
        return keccak256(
            abi.encodePacked(
                _block.index,
                _block.previousHash,
                _block.timestamp,
                _block.data,
                _block.nonce
            )
        );
    }

    function calculateHashWithNonce(
        uint index,
        bytes32 previousHash,
        uint timestamp,
        string memory data,
        uint nonce
    ) internal pure returns (bytes32) {
        return keccak256(
            abi.encodePacked(index, previousHash, timestamp, data, nonce)
        );
    }

    function isValidHash(bytes32 _hash) internal view returns (bool) {
        for (uint i = 0; i < difficulty; i++) {
            if (_hash[i] != 0x00) return false;
        }
        return true;
    }

    function getLatestBlock() public view returns (Block memory) {
        return blockchain[blockchain.length - 1];
    }

    function getChainLength() public view returns (uint) {
        return blockchain.length;
    }
}
