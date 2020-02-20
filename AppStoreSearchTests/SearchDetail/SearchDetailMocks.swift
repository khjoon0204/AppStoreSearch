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

let kakaobank_id = 1258016944

// MARK: - SearchDetailBuildableMock class

/// A SearchDetailBuildableMock class used for testing.
class SearchDetailBuildableMock: SearchDetailBuildable {

    // Function Handlers
    var buildHandler: ((_ listener: SearchDetailListener) -> SearchDetailRouting)?
    var buildCallCount: Int = 0

    init() {
    }

    func build(withListener listener: SearchDetailListener, id: Int) -> SearchDetailRouting {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        fatalError("Function build returns a value that can't be handled with a default value and its handler must be set")
    }
    
}

// MARK: - SearchDetailInteractableMock class

/// A SearchDetailInteractableMock class used for testing.
class SearchDetailInteractableMock: SearchDetailInteractable {
    // Variables
    var router: SearchDetailRouting? { didSet { routerSetCallCount += 1 } }
    var routerSetCallCount = 0
    var listener: SearchDetailListener? { didSet { listenerSetCallCount += 1 } }
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

// MARK: - SearchDetailRoutingMock class

/// A SearchDetailRoutingMock class used for testing.
class SearchDetailRoutingMock: SearchDetailRouting {
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
    var attachChildHandler: ((_ child: Routing) -> ())?
    var attachChildCallCount: Int = 0
    var detachChildHandler: ((_ child: Routing) -> ())?
    var detachChildCallCount: Int = 0
    var loadHandler: (() -> ())?
    var loadCallCount: Int = 0
//    var cleanupViewsHandler: (() -> ())?
//    var cleanupViewsCallCount: Int = 0

    init(interactable: Interactable,
         viewControllable: ViewControllable) {
        self.interactable = interactable
        self.viewControllable = viewControllable
    }

//    func cleanupViews() {
//        cleanupViewsCallCount += 1
//        if let cleanupViewsHandler = cleanupViewsHandler {
//            return cleanupViewsHandler()
//        }
//    }
    
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

class SearchDetailViewControllableMock: SearchDetailViewControllable, SearchDetailPresentable {
    var listener: SearchDetailPresentableListener?
    
    // Variables
    var uiviewController: UIViewController = UIViewController() { didSet { uiviewControllerSetCallCount += 1 } }
    var uiviewControllerSetCallCount = 0

    // Function Handlers
    var presentHandler: ((_ viewController: ViewControllable) -> ())?
    var presentCallCount: Int = 0
    var dismissHandler: ((_ viewController: ViewControllable) -> ())?
    var dismissCallCount: Int = 0

    init() {
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
