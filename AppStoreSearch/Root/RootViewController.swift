//
//  RootViewController.swift
//  AppStoreSearch
//
//  Created by N17430 on 16/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    
    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        print(#function)
        
//        view.backgroundColor = UIColor.white
    }
    
    
    func present(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        viewController.uiviewController.modalTransitionStyle = .crossDissolve
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    
}

// MARK: SearchTabbarViewControllable

extension RootViewController: SearchTabbarViewControllable {

}
