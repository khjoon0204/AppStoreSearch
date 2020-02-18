//
//  SearchTabbarRouter.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchTabbarInteractable: Interactable, SearchDetailListener {
    var router: SearchTabbarRouting? { get set }
    var listener: SearchTabbarListener? { get set }
}

protocol SearchTabbarViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func push(viewController: ViewControllable)
}

final class SearchTabbarRouter: ViewableRouter<SearchTabbarInteractable, SearchTabbarViewControllable>, SearchTabbarRouting {

 
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: SearchTabbarInteractable,
                  viewController: SearchTabbarViewControllable,
                  searchDetailBuilder: SearchDetailBuildable) {
        self.searchDetailBuilder = searchDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - Private
    private let searchDetailBuilder: SearchDetailBuildable
    
    func routeToSearchDetail(id: Int) {
        
        let searchDetail = searchDetailBuilder.build(withListener: interactor, id: id)
        attachChild(searchDetail)
        viewController.push(viewController: searchDetail.viewControllable)
    }
    
    
}
