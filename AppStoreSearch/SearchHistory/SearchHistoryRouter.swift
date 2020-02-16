//
//  SearchHistoryRouter.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchHistoryInteractable: Interactable {
    var router: SearchHistoryRouting? { get set }
    var listener: SearchHistoryListener? { get set }
}

protocol SearchHistoryViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchHistoryRouter: ViewableRouter<SearchHistoryInteractable, SearchHistoryViewControllable>, SearchHistoryRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchHistoryInteractable, viewController: SearchHistoryViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
