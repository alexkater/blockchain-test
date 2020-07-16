//
//  Response.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation

// MARK: - BitcoinResponse
struct BitcoinResponse: Codable {
    let addresses: [Address]
    let wallet: Wallet
    let txs: [Tx]
}

// MARK: - Address
struct Address: Codable {
    let address: String
    let finalBalance: Int
}

// MARK: - Tx
struct Tx: Codable {
    let hash: String
    let fee: Int
    let result, balance, time: Int
}

// MARK: - Wallet
struct Wallet: Codable {
    let finalBalance: Int
}
