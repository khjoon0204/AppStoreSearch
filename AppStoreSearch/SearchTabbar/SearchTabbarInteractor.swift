//
//  SearchTabbarInteractor.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//


import RxSwift
import CoreData

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
    
    let app = UIApplication.shared.delegate as! AppDelegate

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
    
    func routeToSearchDetail() {
        
    }
    
    
    
    // MARK: - Core Data
    
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
    
    func fetchHistory(complete: @escaping ([NSManagedObject]) -> ()){

        let managedContext = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SearchHistory")

        do {
            let objs = try managedContext.fetch(fetchRequest)
            complete(objs)
//            history_obs.accept(obj)
        } catch let error as NSError {
            CoreDataError.CannotFetch("히스토리 데이터를 가져올 수 없습니다 \(error), \(error.userInfo)")
        }
    }
    func fetchLatest(complete: @escaping ([NSManagedObject]) -> ()){

        let managedContext = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LatestInput")

        do {
            let objs = try managedContext.fetch(fetchRequest)
            complete(objs)
        } catch let error as NSError {
            CoreDataError.CannotFetch("최근검색 데이터를 가져올 수 없습니다 \(error), \(error.userInfo)")
        }
    }
    func saveHistory(title: String, id: String, complete: @escaping ([NSManagedObject]) -> ()) {
        let managedContext = app.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SearchHistory", in: managedContext)!
        let obj = NSManagedObject(entity: entity, insertInto: managedContext)
        obj.setValue(Date(), forKey: "date_create")
        obj.setValue(title, forKeyPath: "title")
        obj.setValue(id, forKeyPath: "trackId")
        
        do {
            try managedContext.save()
            complete([obj])
        } catch let error as NSError {
            CoreDataError.CannotUpdate("히스토리 데이터를 저장할 수 없습니다 \(error), \(error.userInfo)")
        }
    }
    
    func saveLatest(text: String, complete: @escaping ([NSManagedObject]) -> ()) {
        let managedContext = app.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LatestInput", in: managedContext)!
        let obj = NSManagedObject(entity: entity, insertInto: managedContext)
        obj.setValue(Date(), forKey: "date_create")
        obj.setValue(text, forKeyPath: "input_text")
        
        do {
            try managedContext.save()
            complete([obj])
        } catch let error as NSError {
            CoreDataError.CannotUpdate("최근검색 데이터를 저장할 수 없습니다 \(error), \(error.userInfo)")
        }
    }
    
}
