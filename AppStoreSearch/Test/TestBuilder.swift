//
//  TestBuilder.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

protocol TestDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TestComponent: Component<TestDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TestBuildable: Buildable {
    func build(withListener listener: TestListener) -> TestRouting
}

final class TestBuilder: Builder<TestDependency>, TestBuildable {

    override init(dependency: TestDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TestListener) -> TestRouting {
        let component = TestComponent(dependency: dependency)
//        let viewController = TestViewController()
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "TestViewController") as! TestViewController
        let interactor = TestInteractor(presenter: viewController)
        interactor.listener = listener
        return TestRouter(interactor: interactor, viewController: viewController)
    }
}
