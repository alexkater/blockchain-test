//
//  TransactionCellViewModel.swift
//  Blockchain
//
//  Created by Alejandro Arjonilla Garcia on 20/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import Foundation

struct Section {
    let title: String
    var items: [TransactionCellViewModel]
}

struct TransactionCellViewModel: Hashable {
    let id: String
    let title: String
    let subtitle: String
    private(set) var date: String? = nil

    init(
        id: String,
        title: String,
        subtitle: String,
        dateNumber: Int? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle

        if let dateNumber = dateNumber {
            let date = Date(timeIntervalSince1970: Double(dateNumber))
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            self.date = formatter.string(from: date)
        }
    }
}
