//
//  SearchTabbarInteractorTests.swift
//  AppStoreSearchTests
//
//  Created by N17430 on 20/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

@testable import AppStoreSearch
import XCTest
import Quick
import Nimble

final class SearchTabbarInteractorTests: QuickSpec {

    private var interactor: SearchTabbarInteractor!
    

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        // TODO: instantiate objects and mocks
    }

    // MARK: - Tests

//    func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
//        // This is an example of an interactor test case.
//        // Test your interactor binds observables and sends messages to router or listener.
//
//    }
    
    override func spec() {
        beforeSuite {
            // interactor 정의
            self.interactor = SearchTabbarInteractor(presenter: SearchTabbarViewControllableMock())
        }
        describe("") {
            it("검색 성공 검색어:'카카오 뱅크'"){
                waitUntil(timeout: 2) { (done) in
                    self.interactor.fetchSearch(term: "카카오 뱅크") { (objs) in
                        done()
                        expect(Search.parseJSON(objs).count) > 0
                    }
                }
            }
            
            it("최근 검색어 저장 불러오기") {
                waitUntil(timeout: 2) { (done) in
                    self.interactor.saveLatest(text: "최근검색어테스트") { (objs) in
                        self.interactor.fetchLatest { (objs) in
                            done()
                            expect(objs.first?.value(forKey: "input_text") as? String) == "최근검색어테스트"
                        }
                    }
                }
            } // end - it
            
            it("히스토리 저장 불러오기") {
                waitUntil(timeout: 2) { (done) in
                    self.interactor.saveHistory(title: "히스토리테스트", id: "\(kakaobank_id)") { (objs) in
                        self.interactor.fetchHistory { (objs) in
                            done()
                            expect(objs.first?.value(forKey: "title") as? String) == "히스토리테스트"
                        }
                    }
                }
            } // end - it
        } // end - describe
    }
        
}
