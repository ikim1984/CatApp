//
//  Mockservice.swift
//  CatsAppTests
//
//  Created by Miguel Saravia on 5/7/24.
//

import XCTest
import Networking
@testable import CatsApp

struct MockData {
  let mockModel: [CatsModel] = [
    CatsModel(id: "P7XxICTz4kfqrwB0", mimetype: "image/jpeg", size: 21454, tags: ["funny", "hehe"]),
    CatsModel(id: "vT8XDkLUXepwWR7u", mimetype: "image/jpeg", size: 50463, tags: ["funny", "black", "cute"]),
    CatsModel(id: "YxFaRBNhBAMi1vBP", mimetype: "image/jpeg", size: 50463, tags: ["funny", "black", "cute", "drop", "tear"]),
    CatsModel(id: "RUjw2VT9sJ1DUzW4", mimetype: "image/jpeg", size: 67454, tags: ["funny", "hehe", "heart", "hand", "resistance"]),
    CatsModel(id: "PH1F2uldJim7CLaf", mimetype: "image/jpeg", size: 21009, tags: ["funny", "hehe", "doll", "orange"]),
  ]
}

final class MockService: ApiProtocol {
  func service<T>(method: String, model: T.Type, endPoint: String, parameters: [String : Any], completion: @escaping (Result<T, any Error>?) -> Void) where T : Decodable {
    
    let url = URL(string: "https://cataas.com/api/cats?limit=5&skip=0")
    var request = URLRequest(url: url!)
    request.httpMethod = "get"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      let responseTest =
            """
            [
                {
                    "id": "P7XxICTz4kfqrwB0",
                    "mimetype": "image/jpeg",
                    "size": 21454,
                    "tags": ["funny", "hehe"]
                },
                {
                    "id": "vT8XDkLUXepwWR7u",
                    "mimetype": "image/jpeg",
                    "size": 50463,
                    "tags": ["funny", "black", "cute"]
                },
                {
                    "id": "YxFaRBNhBAMi1vBP",
                    "mimetype": "image/jpeg",
                    "size": 50463,
                    "tags": ["funny", "black", "cute", "drop", "tear"]
                },
                {
                    "id": "RUjw2VT9sJ1DUzW4",
                    "mimetype": "image/jpeg",
                    "size": 67454,
                    "tags": ["funny", "hehe", "heart", "hand", "resistance"]
                },
                {
                    "id": "PH1F2uldJim7CLaf",
                    "mimetype": "image/jpeg",
                    "size": 21009,
                    "tags": ["funny", "hehe", "doll", "orange"]
                }
            ]
            """
      let dataTest = responseTest.data(using: .utf8)
      
      if let data = dataTest {
        do {
          let response = try JSONDecoder().decode(T.self, from: data)
          completion(.success(response))
        } catch let error as NSError {
          completion(.failure(error))
        }
      }
    }.resume()
  }
}

final class viewmodelTest: ViewModelProtocol {
  let mockData = MockData().mockModel
  let mockService = MockService()
  func fetchCats(limit: Int, skip: Int, completion: @escaping (Result<[CatsModel], Error>) -> Void) {
    mockService.service(method: "test", model: [CatsModel].self, endPoint: "test", parameters: [:]) { response in
      switch response {
      case .success(let success):
        completion(.success(success))
      case .failure(let failure):
        completion(.failure(failure))
      default:
        return
      }
    }
  }
  
  func handleModelCell(response: [CatsModel]) -> [CatCellModel] {
    return mockData.compactMap { CatCellModel(image: $0.id!, tag: $0.tags!) }
  }
}

final class detailViewModelTest: detailViewModelProtocol {
//  let mockModel = DetailViewModel(detailCat: CatCellModel(image: "P7XxICTz4kfqrwB0", tag: ["funny", "hehe"]))
  let mockModel = CatCellModel(image: "P7XxICTz4kfqrwB0", tag: ["funny", "hehe"])
  
  var imagePath: String {
    mockModel.image
  }
  
  var tagCat: [String] {
    mockModel.tag
  }

}
