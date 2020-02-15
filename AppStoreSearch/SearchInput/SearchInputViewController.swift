//
//  SearchInputViewController.swift
//  AppStoreSearch
//
//  Created by N17430 on 14/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift
import UIKit


protocol SearchInputPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchInputViewController: UIViewController, SearchInputPresentable, SearchInputViewControllable {

    weak var listener: SearchInputPresentableListener?
}
