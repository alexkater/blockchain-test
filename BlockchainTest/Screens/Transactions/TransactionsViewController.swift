//
//  TransactionsViewController.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class TransactionsViewController: BindableViewController<TransactionsView, TransactionsViewModelProtocol> {
    private var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = layout.titleLabel
    }

    // MARK: - Bind View Model

    func bindViewModel() {

        viewModel.sections
            .map { $0.count == 0 }
            .bind(to: layout.isTableViewHidden)
            .disposed(by: disposeBag)

        viewModel.sections
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (sections) in
                self?.sections = sections
                self?.layout.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.title
            .bind(to: layout.titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.isLoadingObservable.distinctUntilChanged()
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (isLoading) in
                guard let strongSelf = self else { return }
                if isLoading {
                    let loadingView = UIActivityIndicatorView(style: .large)
                    strongSelf.layout.addSubview(loadingView)
                    loadingView.center = strongSelf.layout.center
                    strongSelf.layout.loadingView = loadingView
                    loadingView.startAnimating()
                } else {
                    strongSelf.layout.loadingView?.removeFromSuperview()
                }
            }).disposed(by: disposeBag)

        viewModel.error.distinctUntilChanged()
            .compactMap{ $0 }
            .subscribe(onNext: show(error:)).disposed(by: disposeBag)

        _ = viewModel.title.single()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (_) in
                self.layout.titleLabel.transform = CGAffineTransform(scaleX: 0, y: -20)
                self.layout.titleLabel.alpha = 0
                UIView.animate(withDuration: 1,
                               delay: 0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 5,
                               options: .curveLinear
                    , animations: {
                        self.layout.titleLabel.alpha = 1
                        self.layout.titleLabel.transform = .identity
                })
            })

        layout.tableView.dataSource = self
    }
}

extension TransactionsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as? TransactionTableViewCell else {
            return UITableViewCell()
        }

        cell.setup(with: sections[indexPath.section].items[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}
