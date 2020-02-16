//
//  SearchHistoryInteractor.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift

protocol SearchHistoryRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchHistoryPresentable: Presentable {
    var listener: SearchHistoryPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchHistoryListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchHistoryInteractor: PresentableInteractor<SearchHistoryPresentable>, SearchHistoryInteractable, SearchHistoryPresentableListener {

    weak var router: SearchHistoryRouting?
    weak var listener: SearchHistoryListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchHistoryPresentable) {
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
