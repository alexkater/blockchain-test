//
//  ResponseSpec.swift
//  BlockchainTestTests
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Quick
import Nimble
@testable import BlockchainTest

class ResponseSpec: QuickSpec {


    override func spec() {
        var response: BitcoinResponse?

        beforeEach {
            response = BitcoinResponse.map(fromJSONFileName: "BitcoinResponse")
        }

        context("Values") {

            it("Is filled") {
                expect(response).toNot(beNil())
            }

            it("Parse worked") {
                expect(response?.addresses.count).to(equal(1))
                expect(response?.addresses.first?.address).to(equal("xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"))
                expect(response?.addresses.first?.finalBalance).to(equal(8549))

                expect(response?.txs.count).to(equal(50))
                expect(response?.txs.first?.hash).to(equal("cbc06203f949804a512290ade05dcab35cf30c16b43bb0ede6f5074f1f8c3b9e"))
                expect(response?.txs.first?.fee).to(equal(36881))
                expect(response?.txs.first?.result).to(equal(-612687))
                expect(response?.txs.first?.balance).to(equal(0))
                expect(response?.txs.first?.time).to(equal(1547223190))

                expect(response?.wallet.finalBalance).to(equal(8549))
            }
        }
    }
}
