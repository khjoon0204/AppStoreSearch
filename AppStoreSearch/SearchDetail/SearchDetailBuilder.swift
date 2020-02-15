//
//  SearchDetailBuilder.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol SearchDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchDetailComponent: Component<SearchDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchDetailBuildable: Buildable {
    func build(withListener listener: SearchDetailListener) -> SearchDetailRouting
}

final class SearchDetailBuilder: Builder<SearchDetailDependency>, SearchDetailBuildable {

    override init(dependency: SearchDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchDetailListener) -> SearchDetailRouting {
        let component = SearchDetailComponent(dependency: dependency)
        let viewController = SearchDetailViewController()
        let interactor = SearchDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchDetailRouter(interactor: interactor, viewController: viewController)
    }
}
