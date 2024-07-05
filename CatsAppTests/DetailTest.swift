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
      let mockservice = CatCellModel(image: "PH1F2uldJim7CLaf", tag: ["funny", "hehe", "doll", "orange"])
      let mockViewmodel = DetailViewModel(detailCat: mockservice)
      detailControllerTest = DetailViewController(viewModel: mockViewmodel)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      detailControllerTest = nil
    }

    func testViewmodel() {
      let responseTag = ["funny", "hehe", "doll", "orange"]
      let responseImage = "PH1F2uldJim7CLaf"
      XCTAssertEqual(detailControllerTest.viewModel.imagePath, responseImage)
      XCTAssertEqual(detailControllerTest.viewModel.tagCat, responseTag)
    }
}
