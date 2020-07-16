//
//  JSONDecoder+Extensions.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation

extension JSONDecoder {

    /// Common json decoder to use to decode xapo's api results
    static var tonsser: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dataDecodingStrategy = .base64
        decoder.dateDecodingStrategy = .deferredToDate
        decoder.nonConformingFloatDecodingStrategy = .throw
        return decoder
    }
}
