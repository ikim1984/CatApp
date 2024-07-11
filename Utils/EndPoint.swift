//
//  EndPoint.swift
//  CatsApp
//
//  Created by Miguel Saravia on 3/7/24.
//

import Foundation

enum EndPoint {
  case catList
  
  var path: String {
    switch self {
    case .catList:
      return "/api/cats"
    }
  }
}

enum Httpmethod: String {
  case GET = "get"
  case POST = "post"
}
