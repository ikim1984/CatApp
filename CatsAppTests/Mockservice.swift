//
//  Mockservice.swift
//  CatsAppTests
//
//  Created by Miguel Saravia on 5/7/24.
//

import XCTest
import Networking
@testable import CatsApp

class MockService: ApiProtocol {
  func service<T>(method: String, model: T.Type, endPoint: String, parameters: [String : Any], completion: @escaping (Result<T, any Error>?) -> Void) where T : Decodable {
    let mockData: [CatsModel] = [
      CatsModel(id: "P7XxICTz4kfqrwB0", mimetype: "image/jpeg", size: 21454, tags: ["funny", "hehe"]),
      CatsModel(id: "vT8XDkLUXepwWR7u", mimetype: "image/jpeg", size: 50463, tags: ["funny", "black", "cute"]),
      CatsModel(id: "YxFaRBNhBAMi1vBP", mimetype: "image/jpeg", size: 50463, tags: ["funny", "black", "cute", "drop", "tear"]),
      CatsModel(id: "RUjw2VT9sJ1DUzW4", mimetype: "image/jpeg", size: 67454, tags: ["funny", "hehe", "heart", "hand", "resistance"]),
      CatsModel(id: "PH1F2uldJim7CLaf", mimetype: "image/jpeg", size: 21009, tags: ["funny", "hehe", "doll", "orange"]),
    ]
    
    let url = URL(string: "https://test.com")
    var request = URLRequest(url: url!)
    request.httpMethod = "get"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      if error != nil {
        if let err = error as NSError? {
          completion(.failure(err))
          return
        }
      }
      
      if let data = data {
        do {
          _ = try JSONDecoder().decode(T.self, from: data)
          completion(.success(mockData as! T))
        } catch let error as NSError {
          completion(.failure(error))
        }
      }
    }.resume()
  }
}
