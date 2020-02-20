//
//  SearchTabbarRouterTests.swift
//  AppStoreSearchTests
//
//  Created by N17430 on 20/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

@testable import AppStoreSearch
import XCTest
import Quick
import Nimble

final class SearchTabbarRouterTests: QuickSpec {

    private var router: SearchTabbarRouter!
    private var searchDetailBuilder: SearchDetailBuildableMock!
    private var searchTabbarInteractor: SearchTabbarInteractableMock!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        // TODO: instantiate objects and mocks
    }

    // MARK: - Tests

//    func test_routeToExample_invokesToExampleResult() {
//        // This is an example of a router test case.
//        // Test your router functions invokes the corresponding builder, attachesChild, presents VC, etc.
//    }
    
    override func spec() {
        beforeSuite {
            self.searchDetailBuilder = SearchDetailBuildableMock()
            self.searchTabbarInteractor = SearchTabbarInteractableMock()
            self.router = SearchTabbarRouter(interactor: self.searchTabbarInteractor, viewController: SearchTabbarViewControllableMock(), searchDetailBuilder: self.searchDetailBuilder)
        }
        
        describe("") {
            it("상품상세로 이동") {
                let searchDetailRouter = SearchDetailRoutingMock(interactable: SearchDetailInteractableMock(), viewControllable: SearchDetailViewControllableMock())
                var assignedListener: SearchDetailListener? = nil
                self.searchDetailBuilder.buildHandler = { (_ listener: SearchDetailListener) -> (SearchDetailRouting) in
                    assignedListener = listener
                    return searchDetailRouter
                }
                
                expect(assignedListener).to(beNil())
                expect(self.searchDetailBuilder.buildCallCount) == 0
                expect(searchDetailRouter.loadCallCount) == 0
                
                self.router.routeToSearchDetail(id: kakaobank_id) // 1258016944
                
                expect(assignedListener).toNot(beNil())
                expect(self.searchDetailBuilder.buildCallCount) == 1
                expect(searchDetailRouter.loadCallCount) == 1
            }
        }
    }
    
}
