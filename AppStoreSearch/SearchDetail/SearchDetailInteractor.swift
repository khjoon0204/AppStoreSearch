//
//  SearchDetailInteractor.swift
//  AppStoreSearch
//
//  Created by N17430 on 15/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift

protocol SearchDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchDetailPresentable: Presentable {
    var listener: SearchDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchDetailListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchDetailInteractor: PresentableInteractor<SearchDetailPresentable>, SearchDetailInteractable, SearchDetailPresentableListener {
    
    weak var router: SearchDetailRouting?
    weak var listener: SearchDetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SearchDetailPresentable, id: Int) {
        super.init(presenter: presenter)
        presenter.listener = self
        self.id = id
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        print("SearchDetailInteractor id=\(id)")
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - Private

    private var id: Int = -1
    
    func fetchLookup(withSuccessHandler success: @escaping ([String : Any]) -> ()) {
        // https://itunes.apple.com/lookup?id=909253
        let url = URL(string: "https://itunes.apple.com/lookup?id=\(id)")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let result = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let res = result as? [String:Any]{
                //                print(res)
                success(res)
            }
            else{print(ApiError.fetchLookup("상품상세결과 가져오기 실패: \(error?.localizedDescription)"))}
        }.resume()
    }
        
    
}
