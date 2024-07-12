//
//  CatsAppUITests.swift
//  CatsAppUITests
//
//  Created by Miguel Saravia on 1/7/24.
//

import XCTest

final class CatsAppUITests: XCTestCase {
  
  let app = XCUIApplication()
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  override func setUp() async throws {
    try await super.setUp()
  }
  
  func testCollectionview() {
    app.launch()
    
    let collection = app.collectionViews
    
    let predicate = NSPredicate(format: "identifier CONTAINS 'itemCat_'")
    collection.cells.element(matching: predicate).firstMatch.tap()
  }
  
  func testDetailView() {
    app.launch()
    
    let collection = app.collectionViews
    collection.element.swipeUp(velocity: .slow)
    
    XCTAssertTrue(collection.element.waitForExistence(timeout: 0.5))
    XCTAssertTrue(collection.cells.element.waitForExistence(timeout: 0.5))
  }
  
  func testNavigationItem() {
    app.launch()
    XCTAssertEqual(app.navigationBars.element.identifier, "Best cats ever")
  }
}
