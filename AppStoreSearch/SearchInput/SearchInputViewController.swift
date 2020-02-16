//
//  SearchInputViewController.swift
//  AppStoreSearch
//
//  Created by N17430 on 14/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift
import UIKit
import RxCocoa

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
    
    override func viewDidLoad() {
        addSearchController()
        setupTableView()
    }
    
    private func addSearchController(){
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
        
//        let searchResults = searchController.searchBar.searchTextField.rx.text.orEmpty
//        .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
//        .distinctUntilChanged()
//        .flatMapLatest { (query) -> Observable<Any> in
//            if query.isEmpty {
//                return .just([])
//            }
//        }
//        .observeOn(MainScheduler.instance)
        
        
    }
    
    private func setupTableView() {
        latestTV.dataSource = self
        latestTV.delegate = self
        latestTV.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        latestTV.register(UINib(nibName: "InputTextCell", bundle: nil), forCellReuseIdentifier: "InputTextCell")
                
        historyTV.dataSource = self
        historyTV.delegate = self
        historyTV.register(UINib(nibName: "LinkCell", bundle: nil), forCellReuseIdentifier: "LinkCell")
        
        listTV.dataSource = self
        listTV.delegate = self
        listTV.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        
    }
    
    
    
}
extension SearchInputViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(#function) \(searchText)")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let searchText = searchBar.text{fetchSearch(term: searchText)}
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func fetchSearch(term: String){
        let term_enc = term.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let url = URL(string: "https://itunes.apple.com/search?term=\(term_enc!)&media=software")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let result = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let res = result as? [String:Any]{
                print(res)
            }
        }.resume()
    }
    
}
extension SearchInputViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
extension SearchInputViewController: UITableViewDelegate{

}
