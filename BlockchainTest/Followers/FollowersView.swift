//
//  FollowersView.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit

class FollowersView: ReusableUIView {

    // MARK: - Properties

    private let cellHeight: CGFloat = 80

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FollowersTableViewCell.self,
                           forCellReuseIdentifier: FollowersTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    var loadingView: UIActivityIndicatorView?

    // MARK: - Styling

    override func styleUI() {
        backgroundColor = .white
    }

    // MARK: - Constraints

    override func makeConstraints() {
        addSubview(tableView)

        tableView.make(constraints: [
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    override func makeBindings() {
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

    }
}

extension FollowersView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
