//
//  CatsView.swift
//  CatPhotoDisplayer
//
//  Created by Jacek K on 12/11/2021.
//

import SwiftUI
import Combine

struct CatsView: View {
  @ObservedObject var viewModel: CatsViewModel
  
  init(viewModel: CatsViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      Text("Cat photos")
        .accessibilityIdentifier("TitleText")
        .padding()
      if (viewModel.cats.isEmpty) {
        Text(viewModel.errorMessage)
      }
      else {
        List(viewModel.cats, id: \.id) { cat in
          HStack {
            RemoteImage(url: cat.url ?? "")
              .scaledToFit()
            if let name = cat.breeds?.first?.name {
              Text(name)
            }
          }
        }
        .accessibilityIdentifier("CatList")
        .listStyle(.plain)
      }
    }
    .onAppear {
      viewModel.onViewAppear()
    }
    .onDisappear() {
      viewModel.onViewDisppear()
    }
  }
}

struct CatsView_Previews: PreviewProvider {
  static let dataService = MockService()
  
  static var previews: some View {
    CatsView(viewModel: CatsViewModel(dataService: dataService))
  }
}

