//
//  WebService.swift
//  CatPhotoDisplayer
//
//  Created by Jacek K on 12/11/2021.
//

import Foundation

protocol DataServiceProtocol {
  func getCatList(completion: @escaping (Result<[Cat], NetworkError>) -> Void)
}

enum NetworkError: Error {
  case transportError
  case serverError(statusCode: Int)
  case noData
  case decodingError
  case encodingError
}

class WebService: DataServiceProtocol {
  let url: URL
  
  //api link is hard-coded as default value
  init(url: URL = URL(string: "https://api.thecatapi.com/v1/images/search?limit=5")!) {
    self.url = url
  }
  
  func getCatList(completion: @escaping (Result<[Cat], NetworkError>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        //dummy debug-print line to let compile error go away as we are not passing error anywhere
        print(error.localizedDescription)
        completion(.failure(.transportError))
        return
      }
      
      if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
        completion(.failure(.serverError(statusCode: response.statusCode)))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      do {
        let cats = try Array(JSONDecoder().decode([Cat].self, from: data))
        completion(.success(cats))
      } catch {
        completion(.failure(.decodingError))
      }
    }
    .resume()
  }
}


