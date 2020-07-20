//
//  ApiServiceTests.swift
//  TonsserChallengeTests
//
//  Created by Alejandro Arjonilla Garcia on 03/07/2020.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import BlockchainTest

class ApiServiceTests: QuickSpec {

    override func spec() {
        var service: ApiServiceProtocol!
        let xpub = "xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"

        beforeEach {
            service = ApiService()
        }

        context("Routes") {

            it("followers created propertly") {
                let expectedUrl = "https://blockchain.info/multiaddr?active=xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"
                expect(ApiService.Route.transactions(xpub).urlConvertible as? String).to(equal(expectedUrl))
            }
        }

        context("Get followers") {
            var response: TxResponse?


            describe("Works") {
                beforeEach {
                    Stubs.transactions()

                    _ = service.getTransactions(with: xpub)
                        .asObservable()
                        .subscribe(onNext: { newValues in
                            response = newValues
                        })
                }

                it("Followrs filled") {
                    expect(response).toEventuallyNot(beNil())
                }
            }

            describe("Fail") {
                var error: Error!

                beforeEach {
                    Stubs.transactions(error: ApiError.invalid)

                    _ = service.getTransactions(with: xpub)
                        .asObservable()
                        .subscribe(onError: { newError in
                            error = newError
                        })
                }

                it("Get error") {
                    expect(error).toEventuallyNot(beNil())
                }
            }
        }
    }
}
