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
import CoreData

enum ViewType: Int {
    case latest // 최근검색어
    case history // 검색히스토리
    case list // 검색결과목록
}

class SearchInputViewController: UIViewController{

    weak var listener: SearchTabbarPresentableListener?
    
    var search_obs = BehaviorRelay<[Search]>(value: [])
    var history_obs = BehaviorRelay<[NSManagedObject]>(value: [])
    var latest_obs = BehaviorRelay<[Section]>(value: [TitleSection(title: "최근 검색어")])
    
    
    var searchController: UISearchController!
    
    lazy var latestCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: latestCVLayout)
        cv.backgroundColor = .systemBackground
        cv.alwaysBounceVertical = true
        cv.register(UINib(nibName: "TitleCell", bundle: nil), forCellWithReuseIdentifier: "TitleCell")
        cv.register(UINib(nibName: "InputTextCell", bundle: nil), forCellWithReuseIdentifier: "InputTextCell")

        return cv
    }()
    
    lazy var latestCVLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.latest_obs.value[sectionIndex].layoutSection()
        }
        return layout
    }()
    lazy var historyTV: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.backgroundColor = .systemBackground
        tv.alwaysBounceVertical = true
        tv.register(UINib(nibName: "LinkCell", bundle: nil), forCellReuseIdentifier: "LinkCell")
        return tv
    }()
    lazy var listTV: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.backgroundColor = .systemBackground
        tv.alwaysBounceVertical = true
        tv.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        return tv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchController()
        bindLatestCV()
        bindHistoryTV()
        bindListTV()
        
    }
    override func viewWillLayoutSubviews() {
        self.latestCV.collectionViewLayout.invalidateLayout()
    }
    
    func bindLatestCV(){
        
        latest_obs.bind(to: latestCV.rx.items) { (cv, idx, obj) -> UICollectionViewCell in
            if cv.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: IndexPath(row: idx, section: 0)) is TitleCell{
                return self.latest_obs.value[idx].configureCell(collectionView: cv, indexPath: IndexPath(row: idx, section: 0))
            }
            if cv.dequeueReusableCell(withReuseIdentifier: "InputTextCell", for: IndexPath(row: idx, section: 0)) is InputTextCell{
                return self.latest_obs.value[idx].configureCell(collectionView: cv, indexPath: IndexPath(row: idx, section: 0))
            }
            return UICollectionViewCell()
        }.disposed(by: bag)
        latestCV.rx.modelSelected(Section.self).asDriver().drive(onNext: { (section) in
            if let sec_input = section as? InputTextSection{
                self.searchController.searchBar.text = sec_input.title
            }
        }).disposed(by: bag)
        
        listener?.fetchLatest(complete: { (objs) in
            let sections = objs.map{InputTextSection(title: $0.value(forKey: "input_text") as? String ?? "")}
            self.latest_obs.accept(self.latest_obs.value + sections)
        })
        
        
    }
    
    func bindHistoryTV(){
        
        
        history_obs.bind(to: historyTV.rx.items(cellIdentifier: "LinkCell", cellType: LinkCell.self)) { (idx, obj, cell) in
            cell.btn.setTitle(obj.value(forKey: "title") as? String ?? "", for: .normal)
        }.disposed(by: bag)
        
        
        listener?.fetchHistory(complete: { (objs) in
            self.history_obs.accept(objs)
        })
    }
    
    func bindListTV(){
        
        search_obs.bind(to: listTV.rx.items(cellIdentifier: "ItemCell", cellType: ItemCell.self)) { (idx, ele, cell) in
            let i = ele.item
            cell.trackName.text = "\(isNil(i["trackName"]))"
        }.disposed(by: bag)
        
        listTV.rx.modelSelected(Search.self).asDriver().drive(onNext: { search in
            let i = search.item
            self.listener?.saveHistory(title: "\(isNil(i["trackName"]))", id: "\(isNil(i["trackId"]))", complete: { (objs) in
                self.history_obs.accept(objs + self.history_obs.value)
            })
        }).disposed(by: bag)
             
    }
    
    private func addSearchController(){
        
        searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "App Store"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        /// Binding
        let searchBar = searchController.searchBar
        
        searchBar.rx.cancelButtonClicked.bind{
            self.viewChange(viewType: .latest)
        }.disposed(by: bag)
        
        searchBar.rx.searchButtonClicked.bind{
            if let searchText = searchBar.text{
                self.listener?.fetchSearch(term: searchText, withSuccessHandler: { (res) in
                    self.search_obs.accept(Search.parseJSON(res))
                    DispatchQueue.main.async {self.viewChange(viewType: .list)}
                })
                self.listener?.saveLatest(text: searchText, complete: { (objs) in
                    let sections = objs.map{InputTextSection(title: $0.value(forKey: "input_text") as? String ?? "")}
                    self.latest_obs.accept([self.latest_obs.value.first!] + sections + self.latest_obs.value.dropFirst())
                    
                })
            }
        }.disposed(by: bag)
        
        searchBar.rx.text.changed.bind{_ in
//            print(searchBar.text)
            if searchBar.text == ""{
                self.viewChange(viewType: .latest)
            }
            else{
                self.viewChange(viewType: .history)
            }
        }.disposed(by: bag)
        
        
    }
    
    func pinToParent(v: UIView){
        NSLayoutConstraint.activate([
        v.topAnchor.constraint(equalTo: view.topAnchor),
        v.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        v.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        v.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func viewChange(viewType: ViewType){
        view.subviews.first?.removeFromSuperview()
        switch viewType {
        case .latest:
            latestCV.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(latestCV)
            pinToParent(v: latestCV)
            break
        case .list:
            listTV.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(listTV)
            pinToParent(v: listTV)
            break
        case .history:
            historyTV.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(historyTV)
            pinToParent(v: historyTV)
            break
        }
    }

    private let bag = DisposeBag()
}
