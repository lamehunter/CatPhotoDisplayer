//
//  CatPhotoDisplayer_Tests.swift
//  CatPhotoDisplayer_Tests
//
//  Created by Jacek K on 17/11/2021.
//

import XCTest
@testable import CatPhotoDisplayer

class CatPhotoDisplayer_Tests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

  func test_CatsViewModel_onViewAppear_stress() {
    for _ in 0..<100 {
      //Given
      let mockService: DataServiceProtocol = MockService()
      var mockCats: [Cat] = []
      mockService.getCatList { result in
        DispatchQueue.main.async {
          do {
            mockCats = try result.get()
          }
          catch {
            //mockCats empty default
          }
        }
      }
      let vm = CatsViewModel(dataService: mockService)
      
      //When
      vm.onViewAppear()
      
      //Then
      if mockCats.isEmpty {
        XCTAssertEqual(vm.cats.count, 0)
      }
      else {
        XCTAssertEqual(vm.cats.count, mockCats.count)
      }
    }
  }

}
