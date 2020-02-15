//
//  SearchInputRouter.swift
//  AppStoreSearch
//
//  Created by N17430 on 14/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchInputInteractable: Interactable {
    var router: SearchInputRouting? { get set }
    var listener: SearchInputListener? { get set }
}

protocol SearchInputViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchInputRouter: ViewableRouter<SearchInputInteractable, SearchInputViewControllable>, SearchInputRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchInputInteractable, viewController: SearchInputViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
