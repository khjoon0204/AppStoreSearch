//
//  SearchDetailRouter.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchDetailInteractable: Interactable {
    var router: SearchDetailRouting? { get set }
    var listener: SearchDetailListener? { get set }
}

protocol SearchDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchDetailRouter: ViewableRouter<SearchDetailInteractable, SearchDetailViewControllable>, SearchDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchDetailInteractable, viewController: SearchDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
