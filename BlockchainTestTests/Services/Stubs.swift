//
//  Stubs.swift
//  TonsserChallengeTests
//
//  Created by Alejandro Arjonilla Garcia on 03/07/2020.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import OHHTTPStubs

struct Stubs {

    static func transactions(error: Error? = nil) {

        stub(condition: pathEndsWith("/multiaddr") && isMethodGET()) { request in
            guard error == nil else {
                return HTTPStubsResponse(error: error!)
            }
            return Stubs.stubResponse(withFileName: "BitcoinResponse")
        }
    }

    static func stubResponse(withFileName fileName: String, code: Int32 = 200) -> HTTPStubsResponse {
        guard let path = Bundle(for: ApiServiceTests.self).path(forResource: fileName, ofType: "json") else {
            fatalError("File \(fileName) not found")
        }

        return fixture(filePath: path, status: code, headers: ["Content-type": "application/json"])
    }
}
