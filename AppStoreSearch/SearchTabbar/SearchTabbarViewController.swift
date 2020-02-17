//
//  SearchTabbarViewController.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift
import UIKit

protocol SearchTabbarPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func fetchSearch(term: String, withSuccessHandler success: @escaping ([String:Any]) -> ())
}

final class SearchTabbarViewController: UITabBarController, SearchTabbarPresentable, SearchTabbarViewControllable {

    weak var listener: SearchTabbarPresentableListener?
    
    override func viewDidLoad() {
        setupViewControllers()
    }
    
    func setupViewControllers(){
        
        let nav = storyboard?.instantiateViewController(identifier: "SearchInputNavigationController") as! UINavigationController
        let vc = storyboard?.instantiateViewController(identifier: "SearchInputViewController") as! SearchInputViewController
        vc.listener = listener
        nav.viewControllers = [vc]
        setViewControllers([nav], animated: false)
        
    }
    
    
}
