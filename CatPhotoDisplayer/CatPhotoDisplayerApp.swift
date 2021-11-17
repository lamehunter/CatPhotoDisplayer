//
//  CatPhotoDisplayerApp.swift
//  CatPhotoDisplayer
//
//  Created by Jacek K on 12/11/2021.
//

import SwiftUI

@main
struct CatPhotoDisplayerApp: App {
  var dataService: DataServiceProtocol
  var catsViewModel: CatsViewModel
  
  init() {
    let uiTesting = ProcessInfo.processInfo.arguments.contains("Testing")
    if (uiTesting) {
      dataService = MockService()
    }
    else {
      dataService = WebService()
    }
    catsViewModel = CatsViewModel(dataService: dataService)
  }
  var body: some Scene {
    WindowGroup {
      CatsView(viewModel: catsViewModel)
    }
  }
}
