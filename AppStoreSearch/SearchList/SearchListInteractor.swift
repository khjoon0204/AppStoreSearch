//
//  SearchListInteractor.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift

protocol SearchListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchListPresentable: Presentable {
    var listener: SearchListPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchListListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchListInteractor: PresentableInteractor<SearchListPresentable>, SearchListInteractable, SearchListPresentableListener {

    weak var router: SearchListRouting?
    weak var listener: SearchListListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchListPresentable) {
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
