//
//  TableViewCell.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit

class FollowersTableViewCell: UITableViewCell {
    static let identifier = "FollowersTableViewCell"
    override var reuseIdentifier: String? {
        return FollowersTableViewCell.identifier
    }

    private(set) lazy var profileImageView: UIImageView = {
        return UIImageView()
    }()

    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    private(set) lazy var primaryPositionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()

    private(set) lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.italicSystemFont(ofSize: 10)
        return label
    }()

    private(set) lazy var clubLabel: UILabel = {
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

    func setup(with viewModel: FollowersViewModel.CellViewModel) {
//        nameLabel.text = viewModel.name
//        countryLabel.text = "ES"
//        primaryPositionLabel.text = "Primary position"
//        clubLabel.text = "Madrid"

    }
}

private extension FollowersTableViewCell {

    func internalInit() {
        styleUI()
        makeConstraints()
    }

    func styleUI() {
        backgroundColor = .white
        selectionStyle = .none
    }

    func makeConstraints() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, primaryPositionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8

        addSubview(profileImageView)
        addSubview(stackView)
        addSubview(countryLabel)
        addSubview(clubLabel)

        profileImageView.make(constraints: [
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])

        stackView.make(constraints: [
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 8)
        ])

        clubLabel.make(constraints: [
            clubLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            clubLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])

        countryLabel.make(constraints: [
            countryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            countryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])

    }
}
