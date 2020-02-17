//
//  SearchTabbarRouter.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchTabbarInteractable: Interactable {
    var router: SearchTabbarRouting? { get set }
    var listener: SearchTabbarListener? { get set }
}

protocol SearchTabbarViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchTabbarRouter: ViewableRouter<SearchTabbarInteractable, SearchTabbarViewControllable>, SearchTabbarRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchTabbarInteractable, viewController: SearchTabbarViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
