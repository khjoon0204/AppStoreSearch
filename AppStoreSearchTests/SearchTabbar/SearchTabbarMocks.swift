//
//  Mocks.swift
//  AppStoreSearchTests
//
//  Created by N17430 on 20/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

@testable import AppStoreSearch

// MARK: - SearchTabbarBuildableMock class

/// A SearchTabbarBuildableMock class used for testing.
class SearchTabbarBuildableMock: SearchTabbarBuildable, SearchDetailBuildable {
    
    // Function Handlers
    var buildHandler: ((_ listener: SearchTabbarListener) -> SearchTabbarRouting)?
    var buildCallCount: Int = 0
    var searchDetailBuildHandler: ((_ listener: SearchDetailListener) -> SearchDetailRouting)?
    var searchDetailBuildCallCount: Int = 0

    init() {
    }

    func build(withListener listener: SearchTabbarListener) -> SearchTabbarRouting {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        fatalError("Function build returns a value that can't be handled with a default value and its handler must be set")
    }
    
    func build(withListener listener: SearchDetailListener, id: Int) -> SearchDetailRouting {
        searchDetailBuildCallCount += 1
        if let searchDetailBuildHandler = searchDetailBuildHandler {
            return searchDetailBuildHandler(listener)
        }
        fatalError("Function searchDetailBuild returns a value that can't be handled with a default value and its handler must be set")
    }

}

// MARK: - SearchTabbarInteractableMock class

/// A SearchTabbarInteractableMock class used for testing.
class SearchTabbarInteractableMock: SearchTabbarInteractable {
    // Variables
    var router: SearchTabbarRouting? { didSet { routerSetCallCount += 1 } }
    var routerSetCallCount = 0
    var listener: SearchTabbarListener? { didSet { listenerSetCallCount += 1 } }
    var listenerSetCallCount = 0
    var isActive: Bool = false { didSet { isActiveSetCallCount += 1 } }
    var isActiveSetCallCount = 0
    var isActiveStreamSubject: PublishSubject<Bool> = PublishSubject<Bool>() { didSet { isActiveStreamSubjectSetCallCount += 1 } }
    var isActiveStreamSubjectSetCallCount = 0
    var isActiveStream: Observable<Bool> { return isActiveStreamSubject }

    // Function Handlers
    var activateHandler: (() -> ())?
    var activateCallCount: Int = 0
    var deactivateHandler: (() -> ())?
    var deactivateCallCount: Int = 0

    init() {
    }

    func activate() {
        activateCallCount += 1
        if let activateHandler = activateHandler {
            return activateHandler()
        }
    }

    func deactivate() {
        deactivateCallCount += 1
        if let deactivateHandler = deactivateHandler {
            return deactivateHandler()
        }
    }


}

// MARK: - SearchTabbarRoutingMock class

/// A SearchTabbarRoutingMock class used for testing.
class SearchTabbarRoutingMock: SearchTabbarRouting {
    var viewControllable: ViewControllable
    
    // Variables
    var interactable: Interactable { didSet { interactableSetCallCount += 1 } }
    var interactableSetCallCount = 0
    var children: [Routing] = [Routing]() { didSet { childrenSetCallCount += 1 } }
    var childrenSetCallCount = 0
    var lifecycleSubject: PublishSubject<RouterLifecycle> = PublishSubject<RouterLifecycle>() { didSet { lifecycleSubjectSetCallCount += 1 } }
    var lifecycleSubjectSetCallCount = 0
    var lifecycle: Observable<RouterLifecycle> { return lifecycleSubject }

    // Function Handlers
    var routeToSearchDetailHandler: (() -> ())?
    var routeToSearchDetailCallCount: Int = 0
    var attachChildHandler: ((_ child: Routing) -> ())?
    var attachChildCallCount: Int = 0
    var detachChildHandler: ((_ child: Routing) -> ())?
    var detachChildCallCount: Int = 0
    var loadHandler: (() -> ())?
    var loadCallCount: Int = 0
    var cleanupViewsHandler: (() -> ())?
    var cleanupViewsCallCount: Int = 0

    init(interactable: Interactable,
         viewControllable: ViewControllable) {
        self.interactable = interactable
        self.viewControllable = viewControllable
    }

    func cleanupViews() {
        cleanupViewsCallCount += 1
        if let cleanupViewsHandler = cleanupViewsHandler {
            return cleanupViewsHandler()
        }
    }

    func routeToSearchDetail(id: Int) {
        routeToSearchDetailCallCount += 1
        if let routeToSearchDetailHandler = routeToSearchDetailHandler {
            return routeToSearchDetailHandler()
        }
    }

    func load() {
        loadCallCount += 1
        if let loadHandler = loadHandler {
            return loadHandler()
        }
    }

    func attachChild(_ child: Routing) {
        attachChildCallCount += 1
        if let attachChildHandler = attachChildHandler {
            return attachChildHandler(child)
        }
    }

    func detachChild(_ child: Routing) {
        detachChildCallCount += 1
        if let detachChildHandler = detachChildHandler {
            return detachChildHandler(child)
        }
    }
}

class SearchTabbarViewControllableMock: SearchTabbarViewControllable, SearchTabbarPresentable {
    var listener: SearchTabbarPresentableListener?
    
    // Variables
    var uiviewController: UIViewController = UIViewController() { didSet { uiviewControllerSetCallCount += 1 } }
    var uiviewControllerSetCallCount = 0

    // Function Handlers
    var pushHandler: ((_ viewController: ViewControllable) -> ())?
    var pushCallCount: Int = 0
    var presentHandler: ((_ viewController: ViewControllable) -> ())?
    var presentCallCount: Int = 0
    var dismissHandler: ((_ viewController: ViewControllable) -> ())?
    var dismissCallCount: Int = 0

    init() {
    }
    
    func push(viewController: ViewControllable) {
        pushCallCount += 1
        if let pushHandler = pushHandler {
            return pushHandler(viewController)
        }
    }
    
    func present(viewController: ViewControllable) {
        presentCallCount += 1
        if let presentHandler = presentHandler {
            return presentHandler(viewController)
        }
    }

    func dismiss(viewController: ViewControllable) {
        dismissCallCount += 1
        if let dismissHandler = dismissHandler {
            return dismissHandler(viewController)
        }
    }
}
