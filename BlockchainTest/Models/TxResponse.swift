//
//  Response.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation

// MARK: - BitcoinResponse
/// Transaction response object, used to get transactions on `ApiService.Route.transactions`
struct TxResponse: Codable {
    let addresses: [Address]
    let wallet: Wallet
    let txs: [Transactions]
}

// MARK: - Address
/// Address info on the `TxResponse` Object
struct Address: Codable {
    let address: String
    let finalBalance: Int
}

// MARK: - Transactions
/// Transactions info
struct Transactions: Codable {
    let hash: String
    let fee: Int
    let result, balance, time: Int

    var isResultSent: Bool { result < 0 }
}

// MARK: - Wallet
/// Info about the wallet retrieved
struct Wallet: Codable {
    let finalBalance: Int
}
