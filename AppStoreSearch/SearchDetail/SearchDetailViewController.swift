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
    
    var sec_obs = BehaviorRelay<[TableViewSection]>(value: []) // TODO: - Section 들 넣기
    
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
    
    private var topH: CGFloat = -1
    
    lazy var navAlphaV: UIView = {
        if let navBar = navigationController?.navigationBar,
            let subV = navBar.subviews.first { // label 아래, uivisualeffectview 위에 있는 뷰.
//            self.topH = navBar.bounds.height
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
    
    func setupTV() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        pinToParent(v: tableView)
    }
    
    func bindTV() {
        tableView.rx.contentOffset.subscribe {
            if let y = $0.element?.y{
                if self.topH == -1 && abs(y) > 0{self.topH = abs(y)}
                let mod = 1 + (y/self.topH)
                self.navAlphaV.alpha = mod > 1 ? 1 : mod
//                                print(self.navAlphaV.alpha)
            }
        }.disposed(by: bag)
        
        sec_obs.bind(to: tableView.rx.items) { (tv, idx, ele) -> UITableViewCell in
//            let i = ele.item
            if tv.dequeueReusableCell(withIdentifier: "DescCell", for: IndexPath(row: idx, section: 0)) is DescCell{
                return self.sec_obs.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0))
            }
            if tv.dequeueReusableCell(withIdentifier: "MoreCell", for: IndexPath(row: idx, section: 0)) is MoreCell{
                return self.sec_obs.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0))
            }
            if tv.dequeueReusableCell(withIdentifier: "ReviewCell", for: IndexPath(row: idx, section: 0)) is ReviewCell{
                return self.sec_obs.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0))
            }
            if tv.dequeueReusableCell(withIdentifier: "NewCell", for: IndexPath(row: idx, section: 0)) is NewCell{
                return self.sec_obs.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0))
            }
            if tv.dequeueReusableCell(withIdentifier: "InfoCell", for: IndexPath(row: idx, section: 0)) is InfoCell{
                return self.sec_obs.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0))
            }
            if tv.dequeueReusableCell(withIdentifier: "HelperCell", for: IndexPath(row: idx, section: 0)) is HelperCell{
                return self.sec_obs.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0))
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
            guard let i = Search.parseJSON(objs).first?.item else{return}
            self.sec_obs.accept([
                DescSection(artWork: isStr(i["artWork"]), trackName: isStr(i["trackName"]), screenshotUrls: i["screenshotUrls"] as! [String]),
                MoreSection(txt: isStr(i["txt"]), nameDeveloper: isStr(i["nameDeveloper"])),
                ReviewSection(lbRating: isStr(i["lbRating"]), lbAnswerCount: isStr(i["lbAnswerCount"]), answers: []),
                NewSection(lbVersion: isStr(i["lbVersion"]), lbBeforeDay: isStr(i["lbBeforeDay"]), lbDesc: isStr(i["lbDesc"])),
                InfoSection(lbProvider: isStr(i["lbProvider"]), lbSize: isStr(i["lbSize"]), lbCategory: isStr(i["lbCategory"]), lbAge: isStr(i["lbAge"])),
                HelperSection()
            ])
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

