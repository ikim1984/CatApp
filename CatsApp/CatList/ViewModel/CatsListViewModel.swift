//
//  CatsListViewModel.swift
//  CatsApp
//
//  Created by Miguel Saravia on 4/7/24.
//

import UIKit
import Networking

final class CatsListViewModel: NSObject {
  private let api = ApiService()
  
  func fetchCats(limit: Int, skip: Int, completion: @escaping (Result<[CatsModel], Error>) -> Void) {
    let parms: [String: String] = [
      "limit":"\(limit)",
      "skip":"\(skip)"
    ]
    api.service(method: Httpmethod.GET.rawValue, model: [CatsModel].self, endPoint: EndPoint.catList.path, parameters: parms) { response in
      switch response {
      case let .success(success):
        completion(.success(success))
      case let .failure(failure):
        completion(.failure(failure))
      default:
        return
      }
    }
  }
}
