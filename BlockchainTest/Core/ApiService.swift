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

protocol ApiServiceProtocol {
//    func getFollowers(with lastSlug: String?) -> Single<[Follower]>
}

enum ApiError: Error {
    case invalid
}

class ApiService: ApiServiceProtocol {
    enum Route: String {
        case followers

        private var basePath: String { "http://api.tonsser.com/58/users/peter-holm/" }

        var urlConvertible: URLConvertible {
            basePath.appending(self.rawValue)
        }
    }

//    func getFollowers(with lastSlug: String?) -> Single<[Follower]> {
//        return Single.create { single in
//            AF.request(Route.followers.urlConvertible).responseData(completionHandler: { (response) in
//                if let error = response.error {
//                    single(.error(error))
//                } else if let data = response.data,
//                    let followerResponse = try? JSONDecoder.tonsser.decode(FollowersResponse.self, from: data){
//                    single(.success(followerResponse.followers))
//                } else {
//                    single(.error(ApiError.invalid))
//                }
//            })
//            return Disposables.create()
//        }
//    }
}
