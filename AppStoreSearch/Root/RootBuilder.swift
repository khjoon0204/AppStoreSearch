//
//  RootBuilder.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    let rootViewController: RootViewController

    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
  

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
//        let viewController = RootViewController()
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "RootViewController") as! RootViewController
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        let searchInputBuilder = SearchInputBuilder(dependency: component)
        let testBuilder = TestBuilder(dependency: component)
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          searchInputBuilder: searchInputBuilder,
        testBuilder: testBuilder)
    }
}
