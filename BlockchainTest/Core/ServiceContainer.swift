//
//  ServiceContainer.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation

/// Simple solution to create DI easily, for a profesional use I recommend to use another tool or method,
/// For this test I think is enough
final class ServiceContainer {
    static let shared = ServiceContainer()

    lazy var apiService: ApiServiceProtocol = ApiService()
}
