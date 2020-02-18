//
//  SearchDetailBuilder.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import UIKit

protocol SearchDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var id: Int { get }
}

final class SearchDetailComponent: Component<SearchDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
//    let id: Int
//    init(dependency: SearchDetailDependency, id: Int) {
//        self.id = id
//        super.init(dependency: dependency)
//    }
}

// MARK: - Builder

protocol SearchDetailBuildable: Buildable {
    func build(withListener listener: SearchDetailListener, id: Int) -> SearchDetailRouting
}

final class SearchDetailBuilder: Builder<SearchDetailDependency>, SearchDetailBuildable {

    override init(dependency: SearchDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchDetailListener, id: Int) -> SearchDetailRouting {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "SearchDetailViewController") as! SearchDetailViewController
        let component = SearchDetailComponent(dependency: dependency)
        let interactor = SearchDetailInteractor(presenter: viewController, id: id)
        interactor.listener = listener
        return SearchDetailRouter(interactor: interactor, viewController: viewController)
    }
}
