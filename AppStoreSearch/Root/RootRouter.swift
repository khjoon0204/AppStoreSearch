//
//  RootRouter.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol RootInteractable: Interactable, SearchInputListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func presentSearchInput()
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    let searchInputBuilder: SearchInputBuildable
    var searchInput: ViewableRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  searchInputBuilder: SearchInputBuildable) {
        self.searchInputBuilder = searchInputBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        routToSearchInput()
    }
    
    func routToSearchInput() {
        let searchInput = searchInputBuilder.build(withListener: interactor)
        self.searchInput = searchInput
        attachChild(searchInput)
//        viewController.presentSearchInput()
        viewController.present(viewController: searchInput.viewControllable)
    }
    
    // MARK: - Private
    
}
