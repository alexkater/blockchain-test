//
//  FollowersViewModel.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

struct Follower {

}

class FollowersViewModel {
    struct CellViewModel {

    }

    private let apiService: ApiServiceProtocol
    private let navigationRoute = BehaviorRelay<Route?>(value: nil)
    private var followers = BehaviorRelay<[Follower]>(value: [])
    private var isLoading = BehaviorRelay<Bool>(value: false)

    lazy var cellViewModels = createCellViewModelsObservable()
    lazy var navigationObservable = navigationRoute.asObservable()
    lazy var isLoadingObservable = isLoading.asObservable()

    /// This text should be loxalized, but for the test is just enough
    let title = BehaviorSubject(value: "Followers").asObserver()

    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
        getFollowers()
    }

    func nextPage(for index: Int) {
        guard index > followers.value.count - 5 else { return }
//        getFollowers(with: followers.value.last?.slug)
    }

    func selectItem(with row: Int) {
//        let followerDetailRoute = Route.followerDetail(followers.value[row])
//        navigationRoute.accept(followerDetailRoute)
    }
}

private extension FollowersViewModel {
    func getFollowers(with id: String? = nil) {
        isLoading.accept(true)

//        _ = apiService.getFollowers(with: id)
//            .asObservable()
//            .map { [weak self] newValues in return newValues + (self?.followers.value ?? []) }
//            .subscribe(onNext: { [weak self] newValues in
//                self?.followers.accept(newValues)
//                self?.isLoading.accept(false)
//            })
    }

    func createCellViewModelsObservable() -> Observable<[CellViewModel]> {
        .empty()
    }
}
