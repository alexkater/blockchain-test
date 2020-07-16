//
//  Decodable+Extensions.swift
//  BlockchainTestTests
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation
@testable import BlockchainTest

class BundleTest { }

extension Decodable {

    static func map(fromJSONFileName fileName: String) -> Self? {
        guard let path =  Bundle(for: BundleTest.self).path(forResource: fileName, ofType: "json") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let object: Self = try JSONDecoder.tonsser.decode(Self.self, from: data)
            return object
        } catch {
            print("""
                ---------------------------------
                Could not create \(String(describing: Self.self)) with json file name: \(fileName)

                \(error)
                ---------------------------------
            """)
            return nil
        }

    }

    static func mapArray(fromJSONFileName fileName: String) -> [Self] {
        guard let path =  Bundle(for: BundleTest.self).path(forResource: fileName, ofType: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder.tonsser.decode([Self].self, from: data)
        } catch {
            print("""
                ---------------------------------
                Could not create \(String(describing: Self.self)) with json file name: \(fileName)

                \(error)
                ---------------------------------
                """)
            return []
        }
    }
}
