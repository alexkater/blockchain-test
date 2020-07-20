//
//  SceneDelegate.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene,
            !Thread.current.isRunningXCTest {

            let viewController = Route.transactions.viewController
            let window = UIWindow(windowScene: windowScene)
            window.overrideUserInterfaceStyle = .light

            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.isTranslucent = true

            window.rootViewController = navigationController

            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

extension Thread {
  var isRunningXCTest: Bool {
    for key in self.threadDictionary.allKeys {
      guard let keyAsString = key as? String else {
        continue
      }

      if keyAsString.split(separator: ".").contains("xctest") {
        return true
      }
    }
    return false
  }
}

