//
//  CatsViewModel.swift
//  CatPhotoDisplayer
//
//  Created by Jacek K on 12/11/2021.
//
import Foundation

class CatsViewModel: ObservableObject {
  private var dataService: DataServiceProtocol
  private var timer: Timer? = nil
  
  @Published var cats: [Cat] = []
  var errorMessage: String = ""
  
  init(dataService: DataServiceProtocol) {
    self.dataService = dataService
  }
  
  private func getLatestCatListFromAPI() {
    dataService.getCatList { result in
      DispatchQueue.main.async {
        do {
          self.cats = try result.get()
        }
        catch {
          self.errorMessage = "Cats couldn't be displayed due error related to internet connection"
          self.cats = [Cat]()
        }
      }
    }
  }
  
  private func startRefreshingCatList(every seconds: TimeInterval) {
    print("Cat list is now refreshed every \(seconds) seconds.")
    timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true, block: { _ in
      self.getLatestCatListFromAPI()
    })
  }
  
  private func stopRefreshingCatList() {
    print("Cat list won't be refreshed anymore.")
    timer?.invalidate()
    timer = nil
  }
  
  func onViewAppear() {
    getLatestCatListFromAPI()
    startRefreshingCatList(every: 20)
  }
  
  func onViewDisppear() {
    stopRefreshingCatList()
  }
}

