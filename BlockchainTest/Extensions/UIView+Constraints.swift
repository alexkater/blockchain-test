//
//  UIView+Constraints.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit

extension UIView {

    func make(constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        constraints.forEach {
            $0.isActive = true
        }
    }
}
