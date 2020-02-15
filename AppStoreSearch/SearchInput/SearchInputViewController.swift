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
    
    @IBOutlet weak var latestV0: UIView!
    @IBOutlet weak var latestTV: UITableView!
    @IBOutlet weak var historyV0: UIView!
    @IBOutlet weak var historyTV: UITableView!
    @IBOutlet weak var listV0: UIView!
    @IBOutlet weak var listTV: UITableView!
    
    
}

//extension SearchInputViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
//extension SearchInputViewController: UICollectionViewDelegate{
//
//}
