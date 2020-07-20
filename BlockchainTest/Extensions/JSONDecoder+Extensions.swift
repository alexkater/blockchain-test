//
//  JSONDecoder+Extensions.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation

extension JSONDecoder {

    /// Common json decoder to use to decode blockchain's api results
    static var blockchain: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dataDecodingStrategy = .base64
        decoder.dateDecodingStrategy = .deferredToDate
        decoder.nonConformingFloatDecodingStrategy = .throw
        return decoder
    }
}
