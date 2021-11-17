//
//  CatPhotoDisplayer_UITests.swift
//  CatPhotoDisplayer_UITests
//
//  Created by Jacek K on 17/11/2021.
//

import XCTest

class CatPhotoDisplayer_UITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

  func test_CatsView_List_shouldReturnTenOrZeroCats() throws {
    // Given
    let app = XCUIApplication()
    app.launchArguments.append("Testing")
    app.launch()
    sleep(5)
    
    // When
    let tablesQuery = XCUIApplication().tables
    let count = tablesQuery.children(matching: .cell).count
    
    // Then
    
    // Explanation
    // Expected count = 0 if there is mockService error, and 10 if mockService doesnt have error
    // This is hard-coded assumption as we know the mockService always return 10 cats - the UI test is blackboxed, possible solution to get
    let expectedCount = [0, 10]
    XCTAssert(expectedCount.contains(count))
  }
  
  func test_CatsView_staticText_shouldBeDisplayed() throws {
    // Given
    let app = XCUIApplication()
    app.launchArguments.append("Testing")
    app.launch()
    sleep(5)
    
    // When
    let titleText = app.staticTexts["TitleText"]
    
    // Then
    XCTAssertTrue(titleText.exists)
  }
}
