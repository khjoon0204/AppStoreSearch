//
//  SearchHistoryBuilder.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchHistoryDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchHistoryComponent: Component<SearchHistoryDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchHistoryBuildable: Buildable {
    func build(withListener listener: SearchHistoryListener) -> SearchHistoryRouting
}

final class SearchHistoryBuilder: Builder<SearchHistoryDependency>, SearchHistoryBuildable {

    override init(dependency: SearchHistoryDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchHistoryListener) -> SearchHistoryRouting {
        let component = SearchHistoryComponent(dependency: dependency)
        let viewController = SearchHistoryViewController()
        let interactor = SearchHistoryInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchHistoryRouter(interactor: interactor, viewController: viewController)
    }
}
