//
//  Route.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 06/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit
import Foundation

/// Navigation Route for different screens, here you should fill ViewController and ViewModel
enum Route: Equatable {
    /// Transactions list screen, used as main screen
    case transactions

    /// used to present or show on the viewController
    var viewController: UIViewController {
        switch self {
        case .transactions:
            let viewModel = TransactionsViewModel(
                apiService: ServiceContainer.shared.apiService,
                // TODO: This value should not be hardcoded, only for this test purpose
                xpub: "xpub6CfLQa8fLgtouvLxrb8EtvjbXfoC1yqzH6YbTJw4dP7srt523AhcMV8Uh4K3TWSHz9oDWmn9MuJogzdGU3ncxkBsAC9wFBLmFrWT9Ek81kQ"
            )
            var viewController = TransactionsViewController()
            viewController.bind(toViewModel: viewModel)
            return viewController
        }
    }
}
