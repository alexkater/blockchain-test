//
//  Route.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 06/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit
import Foundation

enum Route {
    case followersList

    var viewController: UIViewController {
        switch self {
        case .followersList:
            let viewModel = FollowersViewModel(apiService: ServiceContainer.shared.apiService)
            var viewController = FollowerViewController()
            viewController.bind(toViewModel: viewModel)
            return viewController
        }
    }
}

extension Route: Equatable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.followersList, .followersList):
            return true
        default:
            return false
        }
    }
}
