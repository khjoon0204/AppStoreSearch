//
//  SearchTabbarBuilder.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

protocol SearchTabbarDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchTabbarComponent: Component<SearchTabbarDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchTabbarBuildable: Buildable {
    func build(withListener listener: SearchTabbarListener) -> SearchTabbarRouting
}

final class SearchTabbarBuilder: Builder<SearchTabbarDependency>, SearchTabbarBuildable {

    override init(dependency: SearchTabbarDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchTabbarListener) -> SearchTabbarRouting {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "SearchTabbarViewController") as! SearchTabbarViewController
        let component = SearchTabbarComponent(dependency: dependency)
        
        let interactor = SearchTabbarInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchTabbarRouter(interactor: interactor, viewController: viewController)
    }
}
