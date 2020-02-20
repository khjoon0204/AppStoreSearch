//
//  SearchDetailInteractorTests.swift
//  AppStoreSearchTests
//
//  Created by N17430 on 20/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

@testable import AppStoreSearch
import XCTest
import Quick
import Nimble

final class SearchDetailInteractorTests: QuickSpec {

    private var interactor: SearchDetailInteractor!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        // TODO: instantiate objects and mocks
    }

    // MARK: - Tests

//    func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
//        // This is an example of an interactor test case.
//        // Test your interactor binds observables and sends messages to router or listener.
//    }
    
    
    override func spec() {
        beforeSuite {
            // interactor 정의
            self.interactor = SearchDetailInteractor(presenter: SearchDetailViewControllableMock(), id: kakaobank_id)
        }
        describe("") {
            it("상품상세 요청:'카카오 뱅크'"){
                waitUntil(timeout: 2) { (done) in
                    self.interactor.fetchLookup { (objs) in
                        done()
                        expect(Search.parseJSON(objs).count) > 0
                    }
                }
            }
            
        } // end - describe
        
    }
    
}
