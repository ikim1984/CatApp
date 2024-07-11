//
//  DetailTest.swift
//  CatsAppTests
//
//  Created by Miguel Saravia on 5/7/24.
//

import XCTest
@testable import CatsApp

final class DetailTest: XCTestCase {
  var detailControllerTest: DetailViewController!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    let mockViewmodel = detailViewModelTest()
    detailControllerTest = DetailViewController(viewModel: mockViewmodel)
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    detailControllerTest = nil
  }
  
  func testViewmodel() {
    let responseTag = ["funny", "hehe"]
    let responseImage = "P7XxICTz4kfqrwB0"
    XCTAssertEqual(detailControllerTest.viewModel.imagePath, responseImage)
    XCTAssertEqual(detailControllerTest.viewModel.tagCat, responseTag)
  }
}
