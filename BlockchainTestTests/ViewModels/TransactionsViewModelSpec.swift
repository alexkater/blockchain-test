//
//  TransactionsViewModelSpec.swift
//  BlockchainTestTests
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxBlocking
import RxTest

@testable import BlockchainTest

final class TransactionsViewModelSpec: QuickSpec {

    override func spec() {

        var viewModel: TransactionsViewModel!
        var apiService: ApiServiceMock!
        let xpub = "xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"

        beforeEach {
            apiService = ApiServiceMock()
            viewModel = TransactionsViewModel(
                apiService: apiService,
                xpub: xpub
            )
        }

        context("Sections") {

            describe("Loaded") {

                beforeEach {
                    apiService.getTransactionsMock = Single.create { (single) -> Disposable in
                        single(.success(TxResponse.responseMock))
                        return Disposables.create()
                    }

                    viewModel = TransactionsViewModel(
                        apiService: apiService,
                        xpub: xpub
                    )
                }

                it("Success") {
                    let sections = try? viewModel.sections.toBlocking().first()
                    expect(sections).toEventuallyNot(beNil())
                    expect(sections?.count).toEventually(equal(2))
                    expect(sections?[0].title).toEventually(equal("Addresses"))
                    expect(sections?[0].items.first?.title).toEventually(equal(xpub))
                    expect(sections?[0].items.first?.subtitle).toEventually(equal("Balance: 0.00008549"))

                    expect(sections?[1].title).toEventually(equal("Transactions"))

                    expect(sections?[1].items.first?.title).toEventually(equal("Amount: 0.00612687"))
                    expect(sections?[1].items.first?.subtitle).toEventually(equal("Sent"))
                }
            }
        }

        context("Initial state") {

            beforeEach {
                apiService.getTransactionsMock = Single.create { (single) -> Disposable in
                    single(.success(TxResponse.responseMock))
                    return Disposables.create()
                }

                viewModel = TransactionsViewModel(
                    apiService: apiService,
                    xpub: xpub
                )
            }
            it("Built propertly") {
                expect(try viewModel.title.toBlocking().first()).to(equal("Final Balance: 0.00008549"))
            }
        }
    }
}
