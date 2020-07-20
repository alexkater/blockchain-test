//
//  TxResponseMock.swift
//  BlockchainTestTests
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation

@testable import BlockchainTest

extension TxResponse {

    static var responseMock: TxResponse {
        TxResponse.map(fromJSONFileName: "BitcoinResponse")!
    }
}
