//
//  FollowersViewController.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 16/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class FollowerViewController: BindableViewController<FollowersView, FollowersViewModel> {
    private let transition = FollowerAnimator()

    // MARK: - Bind View Model

    func bindViewModel() {

        viewModel.cellViewModels
            .bind(to: layout.tableView.rx
                .items(cellIdentifier: FollowersTableViewCell.identifier,
                       cellType: FollowersTableViewCell.self)) { row, model, cell in
                        cell.setup(with: model)
        }.disposed(by: disposeBag)

        layout.tableView.rx
            .itemSelected
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (indexPath) in
                self?.viewModel.selectItem(with: indexPath.row)
            }).disposed(by: disposeBag)

        viewModel.navigationObservable
            .do(onNext: { [weak self] (route) in
                guard let viewController = route?.viewController else {
                    return
                }
                viewController.modalPresentationStyle = .fullScreen
                viewController.transitioningDelegate = self
                self?.present(viewController, animated: true)
            }).subscribe().disposed(by: disposeBag)

        layout.tableView.rx.willDisplayCell
            .map { $0.indexPath.row }
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe(onNext: viewModel.nextPage)
            .disposed(by: disposeBag)

        viewModel.title
            .bind(to: rx.title)
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
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension FollowerViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard
            let selectedIndexPathCell = layout.tableView.indexPathForSelectedRow,
            let selectedCell = layout.tableView.cellForRow(at: selectedIndexPathCell) as? FollowersTableViewCell
            else {
                return nil
        }

        let originFrame: CGRect = view.convert(selectedCell.profileImageView.frame, from: selectedCell.profileImageView)
        transition.originFrame = originFrame
        transition.isPresenting = true
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
