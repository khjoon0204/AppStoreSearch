//
//  SearchInputBuilder.swift
//  AppStoreSearch
//
//  Created by N17430 on 14/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchInputDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchInputComponent: Component<SearchInputDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let searchInputViewController: SearchInputViewController
    init(dependency: SearchInputDependency,
         searchInputViewController: SearchInputViewController) {
        self.searchInputViewController = searchInputViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol SearchInputBuildable: Buildable {
    func build(withListener listener: SearchInputListener) -> SearchInputRouting
}

final class SearchInputBuilder: Builder<SearchInputDependency>, SearchInputBuildable {

    override init(dependency: SearchInputDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchInputListener) -> SearchInputRouting {
        let viewController = SearchInputViewController()
        let component = SearchInputComponent(dependency: dependency, searchInputViewController: viewController)
        
        let interactor = SearchInputInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchInputRouter(interactor: interactor, viewController: viewController)
    }
}
