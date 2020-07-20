//
//  ApiServiceMock.swift
//  BlockchainTestTests
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation
import RxSwift

@testable import BlockchainTest

final class ApiServiceMock: ApiServiceProtocol {

    var getTransactionsMock: Single<TxResponse>?

    func getTransactions(with xpub: String) -> Single<TxResponse> {
        return getTransactionsMock ?? Single.never()
    }
}
