//
//  CatRequest.swift
//  Components
//
//  Created by Miguel Saravia on 4/7/24.
//

import Foundation

public struct CatCellModel {
  public let image: String
  public let tag: [String]
  
  public init(image: String, tag: [String]) {
    self.image = image
    self.tag = tag
  }
}
