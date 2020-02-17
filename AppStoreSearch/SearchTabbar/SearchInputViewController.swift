//
//  SearchInputViewController.swift
//  AppStoreSearch
//
//  Created by N17430 on 14/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//
import UIKit
import RxSwift
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
    
    weak var listener: SearchTabbarPresentableListener?
    
    var search_obs = BehaviorRelay<[Search]>(value: [])
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        addSearchController()
        setupTableViews()
        bindTableViews()
    }
    
    private func addSearchController(){
        
        searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "App Store"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
         
    }
    
    private func setupTableViews() {
        latestTV.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        latestTV.register(UINib(nibName: "InputTextCell", bundle: nil), forCellReuseIdentifier: "InputTextCell")
        historyTV.register(UINib(nibName: "LinkCell", bundle: nil), forCellReuseIdentifier: "LinkCell")
        listTV.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
    }
    
    private func bindTableViews(){
        search_obs.bind(to: listTV.rx.items(cellIdentifier: "ItemCell", cellType: ItemCell.self)) { (index, ele, cell) in
            let i = ele.item
            cell.trackName.text = "\(isNil(i["trackName"]))"
        }
        .disposed(by: bag)
        
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
    
    private let bag = DisposeBag()
}

extension SearchInputViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(#function) \(searchText)")
        if searchText == ""{
            viewChange(viewType: .latest)
        }
        else{
            viewChange(viewType: .history)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let searchText = searchBar.text{
            listener?.fetchSearch(term: searchText, withSuccessHandler: { (res) in
                self.search_obs.accept(Search.parseJSON(res))
                DispatchQueue.main.async {self.viewChange(viewType: .list)}
            })
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        // TODO: 처음화면으로 전환
        viewChange(viewType: .latest)
    }
     
}
