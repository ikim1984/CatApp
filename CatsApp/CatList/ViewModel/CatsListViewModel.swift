//
//  CatsListViewModel.swift
//  CatsApp
//
//  Created by Miguel Saravia on 4/7/24.
//

import UIKit
import Networking

protocol ViewModelProtocol {
  func fetchCats(limit: Int, skip: Int, completion: @escaping (Result<[CatsModel], Error>) -> Void)
  func handleModelCell(response: [CatsModel]) -> [CatCellModel]
}

final class CatsListViewModel: NSObject, ViewModelProtocol {
  private var apiService: ApiProtocol
  
  init(apiService: ApiProtocol) {
    self.apiService = apiService
  }
  
  func fetchCats(limit: Int, skip: Int, completion: @escaping (Result<[CatsModel], Error>) -> Void) {
    let parms: [String: String] = [
      "limit":"\(limit)",
      "skip":"\(skip)"
    ]
    apiService.service(method: Httpmethod.GET.rawValue, model: [CatsModel].self, endPoint: EndPoint.catList.path, parameters: parms) { response in
      switch response {
      case let .success(success):
        let response = success.filter { ($0.tags?.count ?? -1) > 2 }
        completion(.success(response))
      case let .failure(failure):
        completion(.failure(failure))
      default:
        return
      }
    }
  }
  
  func handleModelCell(response: [CatsModel]) -> [CatCellModel] {
    return response.map { CatCellModel(image: $0.id ?? "",
                                       tag: $0.tags ?? []) }
  }
}
