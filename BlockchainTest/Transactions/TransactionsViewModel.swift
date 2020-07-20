//
//  TransactionsViewModel.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol TransactionsViewModelProtocol {
    /// TableView's sections
    var sections : Observable<[Section]> { get }
    /// Loading observable object to show Indicator View
    var isLoadingObservable : Observable<Bool> { get }
    /// Nav bar title
    var title : Observable<String> { get }
    /// Error string to be shown if needed
    var error: BehaviorRelay<String?> { get }
}

class TransactionsViewModel: TransactionsViewModelProtocol {

    private let apiService: ApiServiceProtocol
    private let navigationRoute = BehaviorRelay<Route?>(value: nil)
    private var response = BehaviorRelay<TxResponse?>(value: nil)
    private var isLoading = BehaviorRelay<Bool>(value: false)

    lazy var sections = createCellViewModelsObservable()
    lazy var navigationObservable = navigationRoute.asObservable().compactMap { $0 }
    lazy var isLoadingObservable = isLoading.asObservable()
    private(set) var error: BehaviorRelay<String?> = .init(value: nil)

    /// This text should be loxalized, but for the test is just enough
    lazy var title = response.asObservable()
        .compactMap { $0?.wallet.finalBalance }
        /// this text should be localized on a profesional project
        .map { "Final Balance: \($0.btcFormat())" }

    init(
        apiService: ApiServiceProtocol,
        xpub: String
    ) {
        self.apiService = apiService
        getTransactions(with: xpub)
    }
}

private extension TransactionsViewModel {

    /// ApiRequest to get transactions
    /// - Parameter xpub: <#xpub description#>
    func getTransactions(with xpub: String) {
        isLoading.accept(true)

        _ = apiService.getTransactions(with: xpub)
            .asObservable()
            .subscribe(onNext: { [weak self] newValue in
                self?.response.accept(newValue)
                self?.isLoading.accept(false)
                }, onError: { [weak self] error in
                    self?.isLoading.accept(false)
                    self?.error.accept(error.localizedDescription)
            })
    }

    /// Map's from `TxResponse` to `[Section]` observables
    func createCellViewModelsObservable() -> Observable<[Section]> {
        response
            .compactMap { $0 }
            .map { response -> [Section] in
                return [
                    Section(title: "Addresses", items: response.addresses.map { address in
                        TransactionCellViewModel(
                            id: address.address,
                            title: address.address,
                            subtitle: "Balance: \(address.finalBalance.btcFormat())"
                        )
                    }),
                    Section(title: "Transactions", items: response.txs.map { transaction in
                        TransactionCellViewModel(
                            id: transaction.hash,
                            title: "Amount: \(abs(transaction.result).btcFormat())",
                            subtitle: transaction.isResultSent ? "Sent" : "Received",
                            dateNumber: transaction.time
                        )
                    })
                ]
        }
    }
}
