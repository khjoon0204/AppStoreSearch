//
//  SearchListBuilder.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchListComponent: Component<SearchListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchListBuildable: Buildable {
    func build(withListener listener: SearchListListener) -> SearchListRouting
}

final class SearchListBuilder: Builder<SearchListDependency>, SearchListBuildable {

    override init(dependency: SearchListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchListListener) -> SearchListRouting {
        let component = SearchListComponent(dependency: dependency)
        let viewController = SearchListViewController()
        let interactor = SearchListInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchListRouter(interactor: interactor, viewController: viewController)
    }
}
