//
//  ApiService.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import RxSwift
import Alamofire
import Foundation

/// ApiService provide request on application
protocol ApiServiceProtocol {

    /// Get Transactions for a determined value
    /// - Parameter xpub: xpub or address where to get transactions
    func getTransactions(with xpub: String) -> Single<TxResponse>
}

/// Internal ApiError to handle different cases on the app
enum ApiError: Error {
    case invalid
}

/// ApiServiceProtocol implementation
class ApiService: ApiServiceProtocol {

    /// `Route` should contain all posible routes for api requests, this is a simple version on how can be done
    enum Route {
        case transactions(String)

        /// Base path for all api requests
        private var basePath: String { "https://blockchain.info" }

        var urlConvertible: URLConvertible {
            switch self {
            case .transactions(let xpub):
                return "\(basePath)/multiaddr?active=\(xpub)"
            }
        }
    }

    func getTransactions(with xpub: String) -> Single<TxResponse> {
        return Single.create { single in
            AF.request(Route.transactions(xpub).urlConvertible).responseData(completionHandler: { (response) in
                if let error = response.error {
                    single(.error(error))
                } else if let data = response.data,
                    let response = try? JSONDecoder.blockchain.decode(TxResponse.self, from: data){
                    single(.success(response))
                } else {
                    single(.error(ApiError.invalid))
                }
            })
            return Disposables.create()
        }
    }
}
