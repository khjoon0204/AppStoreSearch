//
//  SearchTabbarViewController.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift
import UIKit
import CoreData

protocol SearchTabbarPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func fetchSearch(term: String, withSuccessHandler success: @escaping ([String:Any]) -> ())
    func fetchHistory(complete: @escaping ([NSManagedObject]) -> ())
    func saveHistory(title: String, id: String, complete: @escaping ([NSManagedObject]) -> ())
    func fetchLatest(complete: @escaping ([NSManagedObject]) -> ())
    func saveLatest(text: String, complete: @escaping ([NSManagedObject]) -> ())
    func routeToSearchDetail(id: Int)
}

final class SearchTabbarViewController: UITabBarController, SearchTabbarPresentable, SearchTabbarViewControllable {
    
    

    weak var listener: SearchTabbarPresentableListener?
    
    override func viewDidLoad() {
        setupViewControllers()
    }
    
    func setupViewControllers(){
        
        let searchInputVC = (viewControllers?.first as! UINavigationController).viewControllers.first as! SearchInputViewController
        searchInputVC.listener = listener
        
    }
    
    func push(viewController: ViewControllable) {
        (viewControllers?.first as! UINavigationController).pushViewController(viewController.uiviewController, animated: true)
    }
    
}
