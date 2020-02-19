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

class SearchInputViewController: UIViewController, ItemCellDelegate{
    
    weak var listener: SearchTabbarPresentableListener?
    
    var search_obs = BehaviorRelay<[Search]>(value: [])
    var history_obs = BehaviorRelay<[NSManagedObject]>(value: [])
    var latest_obs = BehaviorRelay<[Section]>(value: [TitleSection(title: "최근 검색어")])
    
    
    var searchController: UISearchController!
    
    lazy var latestCV: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: latestCVLayout)
        v.backgroundColor = .systemBackground
        v.alwaysBounceVertical = true
        v.register(UINib(nibName: "TitleCell", bundle: nil), forCellWithReuseIdentifier: "TitleCell")
        v.register(UINib(nibName: "InputTextCell", bundle: nil), forCellWithReuseIdentifier: "InputTextCell")

        return v
    }()
    
    lazy var latestCVLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.latest_obs.value[sectionIndex].layoutSection()
        }
        return layout
    }()
    lazy var historyTV: UITableView = {
        let v = UITableView(frame: .zero)
        v.backgroundColor = .systemBackground
        v.alwaysBounceVertical = true
        v.register(UINib(nibName: "LinkCell", bundle: nil), forCellReuseIdentifier: "LinkCell")
        return v
    }()
    lazy var listTV: UITableView = {
        let v = UITableView(frame: .zero)
        v.backgroundColor = .systemBackground
        v.alwaysBounceVertical = true
        v.separatorStyle = .none        
        v.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        return v
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchController()
        bindLatestCV()
        bindHistoryTV()
        bindListTV()
        
        viewChange(viewType: .latest)
        
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
            self.clickSearch()
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
    
    func clickSearch(){
        if let searchText = searchController.searchBar.text{
            self.listener?.fetchSearch(term: searchText, withSuccessHandler: { (res) in
                self.search_obs.accept(Search.parseJSON(res))
                DispatchQueue.main.async {self.viewChange(viewType: .list)}
            })
            self.listener?.saveLatest(text: searchText, complete: { (objs) in
                let sections = objs.map{InputTextSection(title: $0.value(forKey: "input_text") as? String ?? "")}
                let first10 = Array(([self.latest_obs.value.first!] + sections + self.latest_obs.value.dropFirst()).prefix(11)) // 헤더포함
                self.latest_obs.accept(first10)
                
            })
        }
    }
    
    // MARK: - RX Binding
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
                self.clickSearch()
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
        historyTV.rx.modelSelected(NSManagedObject.self).asDriver().drive(onNext: { obj in
            let trackId = isInt(obj.value(forKey: "trackId"))
            // TODO: - route to SearchDetail
            self.listener?.routeToSearchDetail(id: trackId)
        }).disposed(by: bag)
        
        listener?.fetchHistory(complete: { (objs) in
            self.history_obs.accept(objs)
        })
    }
    
    func bindListTV(){
        
        search_obs.bind(to: listTV.rx.items(cellIdentifier: "ItemCell", cellType: ItemCell.self)) { (idx, ele, cell) in
            let i = ele.item
            cell.dele = self
            if let artwork = URL(string: isStr(i["artworkUrl100"])),
                let scrns = i["screenshotUrls"] as? [String]{
                self.loadURLImage(url: artwork) { (data, img) in
                    cell.artwork60.image = img
                }
                // array.indices.contains(index)
                if scrns.indices.contains(0), let scrn1 = URL(string: scrns[0]){
                    self.loadURLImage(url: scrn1) { (data, img) in
                        cell.screenShot1.image = img
                    }
                }
                if scrns.indices.contains(1), let scrn2 = URL(string: scrns[1]){
                    self.loadURLImage(url: scrn2) { (data, img) in
                        cell.screenShot2.image = img
                    }
                }
                if scrns.indices.contains(2), let scrn3 = URL(string: scrns[2]){
                    self.loadURLImage(url: scrn3) { (data, img) in
                        cell.screenShot3.image = img
                    }
                }
                   
                
            }
            cell.trackName.text = "\(isStr(i["trackName"]))"
            cell.trackName.tag = idx
            // TODO: - User Rating set..
        }.disposed(by: bag)
        
        listTV.rx.modelSelected(Search.self).asDriver().drive(onNext: { search in
            let i = search.item
            self.listener?.saveHistory(title: "\(isStr(i["trackName"]))", id: "\(isStr(i["trackId"]))", complete: { (objs) in
                self.history_obs.accept(objs + self.history_obs.value)
            })
            // TODO: - route to SearchDetail
            let trackId = isInt(i["trackId"])
            self.listener?.routeToSearchDetail(id: trackId)
        }).disposed(by: bag)
             
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
    
    // MARK: - Item Cell Delegate
    func pressReceive(cell: ItemCell) {
//        let i = search_obs.value[cell.trackName.tag].item
        
    }
    

    // MARK: - Util

    func pinToParent(v: UIView){
        NSLayoutConstraint.activate([
        v.topAnchor.constraint(equalTo: view.topAnchor),
        v.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        v.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        v.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

    
    
}

