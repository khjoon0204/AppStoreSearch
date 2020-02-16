//
//  LatestInputBuilder.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//



protocol LatestInputDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LatestInputComponent: Component<LatestInputDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LatestInputBuildable: Buildable {
    func build(withListener listener: LatestInputListener) -> LatestInputRouting
}

final class LatestInputBuilder: Builder<LatestInputDependency>, LatestInputBuildable {

    override init(dependency: LatestInputDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LatestInputListener) -> LatestInputRouting {
        let component = LatestInputComponent(dependency: dependency)
        let viewController = LatestInputViewController()
        let interactor = LatestInputInteractor(presenter: viewController)
        interactor.listener = listener
        return LatestInputRouter(interactor: interactor, viewController: viewController)
    }
}
