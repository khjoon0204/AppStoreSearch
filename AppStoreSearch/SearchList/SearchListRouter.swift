//
//  SearchListRouter.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchListInteractable: Interactable {
    var router: SearchListRouting? { get set }
    var listener: SearchListListener? { get set }
}

protocol SearchListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchListRouter: ViewableRouter<SearchListInteractable, SearchListViewControllable>, SearchListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchListInteractable, viewController: SearchListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
