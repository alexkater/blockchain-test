//
//  UIViewController+Extensions.swift
//  Blockchain
//
//  Created by Alejandro Arjonilla Garcia on 19/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit

extension UIViewController {


    /// Show AlertViewController for an error with a default action
    /// - Parameter error: Error text which will be showed on the AlertViewController
    func show(error: String) {
        let alertController = UIAlertController(title: "Ups!", message: error, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        }))

        present(alertController, animated: true, completion: nil)
    }
}
