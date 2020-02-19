//
//  SearchDetailViewController.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift
import UIKit

protocol SearchDetailPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func fetchLookup(id: Int, withSuccessHandler success: @escaping ([String:Any]) -> ())
}

final class SearchDetailViewController: UIViewController, SearchDetailPresentable, SearchDetailViewControllable {

    weak var listener: SearchDetailPresentableListener?

    
    
    
}
