//
//  LatestInputRouter.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol LatestInputInteractable: Interactable {
    var router: LatestInputRouting? { get set }
    var listener: LatestInputListener? { get set }
}

protocol LatestInputViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LatestInputRouter: ViewableRouter<LatestInputInteractable, LatestInputViewControllable>, LatestInputRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: LatestInputInteractable, viewController: LatestInputViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
