//
//  TransactionsView.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class TransactionsView: ReusableUIView {

    // MARK: - Properties
    private struct DesignConstants {
        static let cellHeight: CGFloat = 80
        static let tableViewTopInset: CGFloat = -40
        static let titleLabelWidth: CGFloat = 200
        static let titleLabelHeight: CGFloat = 44
        static let titleLabelFontSize: CGFloat = 14
    }

    private(set) var isTableViewHidden = BehaviorRelay(value: true)
    private let tableViewTransform = CGAffineTransform(scaleX: 0.001, y: 0.001)

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TransactionTableViewCell.self,
                           forCellReuseIdentifier: TransactionTableViewCell.identifier)
        tableView.estimatedRowHeight = DesignConstants.cellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: DesignConstants.tableViewTopInset, left: 0, bottom: 0, right: 0)
        tableView.alpha = 0
        tableView.transform = tableViewTransform
        return tableView
    }()

    private(set) var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: DesignConstants.titleLabelWidth, height: DesignConstants.titleLabelHeight))
        label.font = UIFont.boldSystemFont(ofSize: DesignConstants.titleLabelFontSize)
        label.textColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        return label
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
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    override func makeBindings() {
        isTableViewHidden
            .delay(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
            .debug()
            .skip(1)
            .subscribe(onNext: { (isHidden) in
                UIView.animate(withDuration: 1,
                               delay: 0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 5,
                               options: .curveEaseInOut
                    , animations: {
                        self.tableView.alpha = isHidden ? 0:1
                        self.tableView.transform = isHidden ?
                            self.tableViewTransform:
                            .identity
                })
            })
            .disposed(by: disposeBag)
    }
}
