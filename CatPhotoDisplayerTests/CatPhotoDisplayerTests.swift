//
//  CatPhotoDisplayerTests.swift
//  CatPhotoDisplayerTests
//
//  Created by Jacek K on 12/11/2021.
//

import XCTest
@testable import CatPhotoDisplayer

class CatPhotoDisplayerTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  //  func test_CatsViewModel_onViewAppear_stress() {
  //    for _ in 0..<100 {
  //      //Given
  //      let mockService: DataServiceProtocol = MockService()
  //      var mockCats: [Cat] = []
  //      mockService.getCatList { result in
  //        do {
  //          mockCats = try result.get()
  //        }
  //        catch {
  //          mockCats = [Cat]()
  //        }
  //      }
  //
  //      let vm = CatsViewModel(dataService: mockService)
  //      //When
  //      vm.onViewAppear()
  //      //Then
  //      if mockCats.isEmpty {
  ////        XCTAssertEqual(vm.cats[0].id, mockCats[0].id)
  ////        XCTAssertEqual(vm.cats[0].url, mockCats[0].url)
  ////        XCTAssertEqual(vm.cats[0].breeds?[0].name, mockCats[0].breeds?[0].name)
  //        XCTAssertEqual(vm.cats.count, 0)
  //    }
  //      else {
  //        XCTAssertEqual(vm.cats.count, mockCats.count)
  //      }
  //    }
  //  }
  //
  
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


