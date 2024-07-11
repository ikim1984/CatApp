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
    let viewModelTest = viewmodelTest()
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
  
  func testCheckResponse() {
    let mockResponse: [CatsModel] = [
      CatsModel(id: "P7XxICTz4kfqrwB0", mimetype: "image/jpeg", size: 21454, tags: ["funny", "hehe"]),
      CatsModel(id: "vT8XDkLUXepwWR7u", mimetype: "image/jpeg", size: 50463, tags: ["funny", "black", "cute"]),
      CatsModel(id: "YxFaRBNhBAMi1vBP", mimetype: "image/jpeg", size: 50463, tags: ["funny", "black", "cute", "drop", "tear"])
    ]
    let handleResponseTest = catController.viewModel.handleModelCell(response: mockResponse)
    
    XCTAssertEqual(handleResponseTest.count, 5)
  }
}
