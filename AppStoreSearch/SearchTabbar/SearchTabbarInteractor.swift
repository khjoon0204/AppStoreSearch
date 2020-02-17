//
//  SearchTabbarInteractor.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift

protocol SearchTabbarRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchTabbarPresentable: Presentable {
    var listener: SearchTabbarPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchTabbarListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchTabbarInteractor: PresentableInteractor<SearchTabbarPresentable>, SearchTabbarInteractable, SearchTabbarPresentableListener {

    weak var router: SearchTabbarRouting?
    weak var listener: SearchTabbarListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchTabbarPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func fetchSearch(term: String, withSuccessHandler success: @escaping ([String:Any]) -> ()){
        let term_enc = term.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        print("term_enc=\(term_enc!)")
        let url = URL(string: "https://itunes.apple.com/search?term=\(term_enc!)&media=software&limit=3")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let result = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let res = result as? [String:Any]{
//                print(res)
                success(res)
            }
            else{ApiError.fetchSearch("검색결과 가져오기 실패: \(error?.localizedDescription)")}
        }.resume()
    }
    
}
