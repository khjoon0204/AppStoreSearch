//
//  TestViewController.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift
import UIKit

protocol TestPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TestViewController: UIViewController, TestPresentable, TestViewControllable {

    weak var listener: TestPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor.white
    }

}
