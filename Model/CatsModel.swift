//
//  CatsModel.swift
//  CatsApp
//
//  Created by Miguel Saravia on 3/7/24.
//

import Foundation

// MARK: - CatModel
struct CatsModel: Codable {
    let id: String?
    let mimetype: String?
    let size: Int?
    let tags: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case mimetype, size, tags
    }
}
