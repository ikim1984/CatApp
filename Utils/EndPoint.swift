//
//  EndPoint.swift
//  CatsApp
//
//  Created by Miguel Saravia on 3/7/24.
//

import Foundation

enum EndPoint {
  case catList
  case cat(id: String)
  
  var path: String {
    switch self {
    case .catList:
      return "/api/cats"
    case .cat(let id):
      return "/cat/\(id)"
    }
  }
}
