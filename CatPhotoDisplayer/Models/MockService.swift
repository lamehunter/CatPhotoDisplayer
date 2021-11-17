//
//  MockService.swift
//  CatPhotoDisplayer
//
//  Created by Jacek K on 16/11/2021.
//

class MockService: DataServiceProtocol {
  var cats: [Cat] = []
  
  func getCatList(completion: @escaping (Result<[Cat], NetworkError>) -> Void) {
    let randomNumber: Int = Int.random(in: 0..<4)
    switch randomNumber {
    case 0:
      completion(.failure(.transportError))
    case 1:
      completion(.failure(.serverError(statusCode: 200)))
    case 2:
      completion(.failure(.noData))
    case 3:
      cats = generateCats()
      completion(.success(cats))
    case 4:
      completion(.failure(.decodingError))
    default:
      break
    }
  }
  
  func generateCats() -> [Cat] {
    //testData - cat_0 with all fields non-nil
    let cat_0: Cat = Cat()
    cat_0.id = "id0"
    cat_0.url = "https://via.placeholder.com/150"
    let catBreed0: Breed = Breed()
    catBreed0.name = "BreedName0"
    cat_0.breeds?.append(catBreed0)
    
    //testData - cat_1 with url=nil
    let cat_1: Cat = Cat()
    cat_1.id = "id1"
    cat_1.url = nil
    let catBreed1: Breed = Breed()
    catBreed1.name = "BreedName1"
    cat_1.breeds?.append(catBreed1)
    
    //testData - cat_2 with breed.name nil
    let cat_2: Cat = Cat()
    cat_2.id = "id2"
    cat_2.url = "https://via.placeholder.com/250"
    let catBreed2: Breed = Breed()
    catBreed2.name = nil
    cat_2.breeds?.append(catBreed2)
    
    //testData - cat_3 with url empty
    let cat_3: Cat = Cat()
    cat_3.id = "id3"
    cat_3.url = ""
    let catBreed3: Breed = Breed()
    catBreed3.name = nil
    cat_3.breeds?.append(catBreed3)
    
    //testData - cat_4 with breed nil
    let cat_4: Cat = Cat()
    cat_4.id = "id4"
    cat_4.url = ""
    cat_4.breeds = nil
    
    //testData - cat_5 with all nil fields
    let cat_5: Cat = Cat()
    cat_5.id = nil
    cat_5.url = nil
    cat_5.breeds = nil
    
    var testCats: [Cat] = []
    testCats.append(contentsOf: [cat_0, cat_1, cat_2, cat_3, cat_4, cat_5])
    
    var randomizedCats: [Cat] = []
    for _ in 0...9 {
      randomizedCats.append(testCats.randomElement() ?? Cat())
    }
    
    return randomizedCats
  }
}

