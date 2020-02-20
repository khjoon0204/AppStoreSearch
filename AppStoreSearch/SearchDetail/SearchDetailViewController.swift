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
    
    var sec_obs = BehaviorRelay<[TableViewSection]>(value: [])
    
    private let bag = DisposeBag()
    
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
        tableView.pinToParent()
    }
    
    func bindTV() {
        tableView.rx.contentOffset.subscribe {
            if let y = $0.element?.y{
                if self.topH == -1 && abs(y) > 0{self.topH = abs(y)}
                let mod = 1 + (y/self.topH)
                self.navAlphaV.alpha = mod > 1 ? 1 : mod
            }
        }.disposed(by: bag)
        
        sec_obs.bind(to: tableView.rx.items) { (tv, idx, ele) -> UITableViewCell in
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
        
        listener?.fetchLookup(withSuccessHandler: { (objs) in
            guard let i = Search.parseJSON(objs).first?.item else{return}
            self.sec_obs.accept([
                DescSection(artWork: isStr(i["artworkUrl512"]), trackName: isStr(i["trackName"]), screenshotUrls: i["screenshotUrls"] as! [String]),
                MoreSection(txt: isStr(i["description"]), nameDeveloper: isStr(i["artistName"])),
                ReviewSection(lbRating: isStr(i["averageUserRating"]), lbAnswerCount: isStr(i["lbAnswerCount"]), answers: []),
                NewSection(lbVersion: isStr(i["version"]), lbBeforeDay: isStr(i["lbBeforeDay"]), lbDesc: isStr(i["releaseNotes"])),
                InfoSection(lbProvider: isStr(i["sellerName"]), lbSize: isInt64(i["fileSizeBytes"]).toMB(), lbCategory: isStr(i["primaryGenreName"]), lbAge: isStr(i["trackContentRating"])),
                HelperSection()
            ])
        })
    }
    
    
}

