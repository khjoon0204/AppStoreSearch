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
        v.register(UINib(nibName: "MoreCell", bundle: nil), forCellReuseIdentifier: "MoreCell")
        v.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        v.register(UINib(nibName: "NewCell", bundle: nil), forCellReuseIdentifier: "NewCell")
        v.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        v.register(UINib(nibName: "HelperCell", bundle: nil), forCellReuseIdentifier: "HelperCell")
        
        return v
    }()
    private var topH: CGFloat = 0.0
    lazy var navAlphaV: UIView = {
        if let navBar = navigationController?.navigationBar,
            let subV = navBar.subviews.first{ // label 아래, uivisualeffectview 위에 있는 뷰.
            self.topH = navBar.bounds.height
            subV.alpha = 0.0
            navBar.shadowImage = UIImage() // bottom line 없앰.
            return subV
        }
        return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindTV()
        setupTV()
    }
    
    func setupTV(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        pinToParent(v: tableView)
    }
    
    
    func bindTV(){
        
        tableView.rx.contentOffset.subscribe {
            if let y = $0.element?.y{
                self.navAlphaV.alpha = 1 + (y/self.topH)
//                print(self.navAlphaV.alpha)
            }
        }.disposed(by: bag)
        
        search_obs.bind(to: tableView.rx.items) { (tv, idx, ele) -> UITableViewCell in
            let i = ele.item
            if let cell = tv.dequeueReusableCell(withIdentifier: "DescCell", for: IndexPath(row: idx, section: 0)) as? DescCell{
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
            if let cell = tv.dequeueReusableCell(withIdentifier: "MoreCell", for: IndexPath(row: idx, section: 0)) as? MoreCell{

                return cell
            }
            if let cell = tv.dequeueReusableCell(withIdentifier: "ReviewCell", for: IndexPath(row: idx, section: 0)) as? ReviewCell{

                return cell
            }
            if let cell = tv.dequeueReusableCell(withIdentifier: "NewCell", for: IndexPath(row: idx, section: 0)) as? NewCell{

                return cell
            }
            if let cell = tv.dequeueReusableCell(withIdentifier: "InfoCell", for: IndexPath(row: idx, section: 0)) as? InfoCell{

                return cell
            }
            if let cell = tv.dequeueReusableCell(withIdentifier: "HelperCell", for: IndexPath(row: idx, section: 0)) as? HelperCell{

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

