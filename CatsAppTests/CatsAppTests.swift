//
//  CatsAppTests.swift
//  CatsAppTests
//
//  Created by Miguel Saravia on 1/7/24.
//

import XCTest
@testable import CatsApp

final class CatsAppTests: XCTestCase {
  var catController: CatListViewController!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    let mockservice = MockService()
    let viewModelTest = CatsListViewModel(apiService: mockservice)
    catController = CatListViewController(viewModel: viewModelTest)
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    catController = nil
  }
  
  func testFetchData() {
    XCTAssertNotNil(catController.loadCats(), "load")
  }
  
  func testPushNavigation() {
    let mock = CatCellModel(image: "PH1F2uldJim7CLaf", tag: ["funny", "hehe", "doll", "orange"])
    
    XCTAssertNotNil(catController.pushNavigation(data: mock), "push")
  }
  
  func testLoadData() {
    catController.checkLastId(isLast: true)
    XCTAssertEqual(catController.skip, 50)
  }
}
