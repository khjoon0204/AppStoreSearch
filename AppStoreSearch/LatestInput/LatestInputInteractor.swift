//
//  LatestInputInteractor.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift

protocol LatestInputRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LatestInputPresentable: Presentable {
    var listener: LatestInputPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LatestInputListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LatestInputInteractor: PresentableInteractor<LatestInputPresentable>, LatestInputInteractable, LatestInputPresentableListener {

    weak var router: LatestInputRouting?
    weak var listener: LatestInputListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LatestInputPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
