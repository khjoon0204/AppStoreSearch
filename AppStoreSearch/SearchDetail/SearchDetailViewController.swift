//
//  SearchDetailViewController.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift
import UIKit
import RxCocoa

protocol SearchDetailPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func fetchLookup(withSuccessHandler success: @escaping ([String:Any]) -> ())
}

final class SearchDetailViewController: UIViewController, SearchDetailPresentable, SearchDetailViewControllable {

    weak var listener: SearchDetailPresentableListener?

    var search_obs = BehaviorRelay<[Search]>(value: [])
    
    lazy var tableView: UITableView = {
        let v = UITableView(frame: .zero)
        v.backgroundColor = .systemBackground
        v.alwaysBounceVertical = true
        v.separatorStyle = .none
        v.register(UINib(nibName: "DescCell", bundle: nil), forCellReuseIdentifier: "DescCell")
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.barStyle = .default
        bindTV()
        setupTV()
    }
    
    func setupTV(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        pinToParent(v: tableView)
    }
    
    func bindTV(){
        
        search_obs.bind(to: tableView.rx.items) { (tv, idx, ele) -> UITableViewCell in
            if let cell = tv.dequeueReusableCell(withIdentifier: "DescCell", for: IndexPath(row: idx, section: 0)) as? DescCell{
                let i = ele.item
                
                if let artwork = URL(string: isStr(i["artworkUrl512"])),
                    let scrns = i["screenshotUrls"] as? [String]{
                    self.loadURLImage(url: artwork) { (data, img) in
                        cell.artWork.image = img
                    }
                    cell.url_obs.accept(scrns.map{(URL(string: $0)!)})

                }
                cell.trackName.text = "\(isStr(i["trackName"]))"
                cell.trackName.tag = idx
                
                // TODO: - User Rating set..
                return cell
            }
            return UITableViewCell()
        }.disposed(by: bag)
        
//        latestCV.rx.modelSelected(Section.self).asDriver().drive(onNext: { (section) in
//            if let sec_input = section as? InputTextSection{
//                self.searchController.searchBar.text = sec_input.title
//                self.clickSearch()
//            }
//        }).disposed(by: bag)

        listener?.fetchLookup(withSuccessHandler: { (objs) in
            self.search_obs.accept(Search.parseJSON(objs))
        })
        
    }
    private let bag = DisposeBag()
    // MARK: - Util

    func pinToParent(v: UIView){
        NSLayoutConstraint.activate([
        v.topAnchor.constraint(equalTo: view.topAnchor),
        v.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        v.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        v.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}
