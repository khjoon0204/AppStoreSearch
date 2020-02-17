//
//  RootRouter.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol RootInteractable: Interactable, SearchTabbarListener, TestListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)

}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  searchTabbarBuilder: SearchTabbarBuildable,
                  testBuilder: TestBuildable) {
        self.testBuilder = testBuilder
        self.searchTabbarBuilder = searchTabbarBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        routToSearchTabbar()
//        routToTest()
    }
    
    func routToTest(){
        let test = testBuilder.build(withListener: interactor)
        self.test = test
        attachChild(test)
        viewController.present(viewController: test.viewControllable)
    }
    
    func routToSearchTabbar() {
        let searchTabbar = searchTabbarBuilder.build(withListener: interactor)
        self.searchTabbar = searchTabbar
        attachChild(searchTabbar)
        viewController.present(viewController: searchTabbar.viewControllable)
    }
    
    // MARK: - Private
    
    let searchTabbarBuilder: SearchTabbarBuildable
    var searchTabbar: ViewableRouting?
    
    let testBuilder: TestBuildable
    var test: ViewableRouting?
}
