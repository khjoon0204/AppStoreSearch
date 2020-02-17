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

enum ViewType: Int {
    case latest // 최근검색어
    case history // 검색히스토리
    case list // 검색결과목록
}

class SearchInputViewController: UIViewController{

    @IBOutlet weak var latestV0: UIView!
    @IBOutlet weak var latestTV: UITableView!
    @IBOutlet weak var historyV0: UIView!
    @IBOutlet weak var historyTV: UITableView!
    @IBOutlet weak var listV0: UIView!
    @IBOutlet weak var listTV: UITableView!
    
//    private var cur_view: ViewType!
    private var search_list: [String:Any]?
    
    
    override func viewDidLoad() {
        addSearchController()
        setupTableView()
        
        
    }
    
    private func addSearchController(){
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "App Store"
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
        
//        listTV.dataSource = self
//        listTV.delegate = self
        listTV.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        
    }
    
    private func bindingSearchList(){
        let ob: Observable<[String:Any]> = Observable.of(search_list!)
        ob.bind(to: listTV.rx.items(cellIdentifier: "ItemCell", cellType: ItemCell.self)) { (index, ele, cell) in
            print(ele)
        }.disposed(by: disposeBag)
        
        
    }
    
    
    private func viewChange(viewType: ViewType){
        listV0.isHidden = true
        latestV0.isHidden = true
        historyV0.isHidden = true
        switch viewType {
        case .latest:
            latestV0.isHidden = false
            break
        case .list:
            listV0.isHidden = false
            break
        case .history:
            historyV0.isHidden = false
            break
        }
    }
    
    private let disposeBag = DisposeBag()
}
extension SearchInputViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(#function) \(searchText)")
        if searchText == ""{
            // TODO: Latest View 로 전환
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let searchText = searchBar.text{
//            listener?.fetchSearch(term: searchText, withSuccessHandler: { (res) in
//                self.search_list = res
//                self.bindingSearchList()
//                self.viewChange(viewType: .list)
//            })
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        // TODO: 처음화면으로 전환
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
