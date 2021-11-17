//
//  Cat.swift
//  CatPhotoDisplayer
//
//  Created by Jacek K on 12/11/2021.
//


/*
 NOTE - Only necessary to task API fields will be parsed
 */

import Foundation

class Cat: Decodable {
  var breeds: [Breed]?
  var id: String?
  var url: String?
}

class Breed: Decodable {
  var id: String?
  var name: String?
}

