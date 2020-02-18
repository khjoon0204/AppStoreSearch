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

    @IBOutlet weak var latestV0: UIView!
    @IBOutlet weak var latestCV: UICollectionView!
    @IBOutlet weak var latestHeight: NSLayoutConstraint!
    @IBOutlet weak var historyV0: UIView!
    @IBOutlet weak var historyTV: UITableView!
    @IBOutlet weak var historyHeight: NSLayoutConstraint!
    @IBOutlet weak var listV0: UIView!
    @IBOutlet weak var listTV: UITableView!
    @IBOutlet weak var listHeight: NSLayoutConstraint!
    
    weak var listener: SearchTabbarPresentableListener?
    
    var search_obs = BehaviorRelay<[Search]>(value: [])
    var history_obs = BehaviorRelay<[NSManagedObject]>(value: [])
    var latest_obs = BehaviorRelay<[Section]>(value: [TitleSection(title: "최근 검색어")])
    
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchController()
        setupTableViews()
        listener?.fetchLatest(complete: { (objs) in
            let sections = objs.map{InputTextSection(title: $0.value(forKey: "input_text") as? String ?? "")}
            self.latest_obs.accept(self.latest_obs.value + sections)
        })
        listener?.fetchHistory(complete: { (objs) in
            self.history_obs.accept(objs)
        })
        
    }
    override func viewWillLayoutSubviews() {
        self.latestCV.collectionViewLayout.invalidateLayout()
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
    
    lazy var latestCVLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.latest_obs.value[sectionIndex].layoutSection()
        }
        return layout
    }()

    private func setupTableViews() {
        latestCV.collectionViewLayout = latestCVLayout
        latestCV.register(UINib(nibName: "TitleCell", bundle: nil), forCellWithReuseIdentifier: "TitleCell")
        latestCV.register(UINib(nibName: "InputTextCell", bundle: nil), forCellWithReuseIdentifier: "InputTextCell")
        historyTV.register(UINib(nibName: "LinkCell", bundle: nil), forCellReuseIdentifier: "LinkCell")
        listTV.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        
        /// Binding

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
                
        history_obs.bind(to: historyTV.rx.items(cellIdentifier: "LinkCell", cellType: LinkCell.self)) { (idx, obj, cell) in
            cell.btn.setTitle(obj.value(forKey: "title") as? String ?? "", for: .normal)
        }.disposed(by: bag)
        
    }
    
    
    private func viewChange(viewType: ViewType){
        latestHeight.priority = UILayoutPriority(rawValue: 1000)
        listHeight.priority = UILayoutPriority(rawValue: 1000)
        historyHeight.priority = UILayoutPriority(rawValue: 1000)
        switch viewType {
        case .latest:
            self.latestHeight.priority = UILayoutPriority(rawValue: 250)
            break
        case .list:
            self.listHeight.priority = UILayoutPriority(rawValue: 250)
            break
        case .history:
            self.historyHeight.priority = UILayoutPriority(rawValue: 250)
            break
        }
    }
    
    private let bag = DisposeBag()
}
