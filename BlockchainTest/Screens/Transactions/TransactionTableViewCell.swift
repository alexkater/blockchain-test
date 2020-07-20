//
//  TableViewCell.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    static let identifier = "TransactionTableViewCell"
    override var reuseIdentifier: String? {
        return TransactionTableViewCell.identifier
    }

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingMiddle
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()

    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.internalInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.internalInit()
    }

    func setup(with viewModel: TransactionCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        dateLabel.text = viewModel.date
    }
}

private extension TransactionTableViewCell {

    func internalInit() {
        styleUI()
        makeConstraints()
    }

    func styleUI() {
        backgroundColor = .white
        selectionStyle = .none
    }

    func makeConstraints() {
        [titleLabel, subtitleLabel, dateLabel].forEach(addSubview)

        titleLabel.make(constraints: [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

        subtitleLabel.make(constraints: [
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            subtitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

        dateLabel.make(constraints: [
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

    }
}
