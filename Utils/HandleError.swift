//
//  HandleError.swift
//  CatsApp
//
//  Created by Miguel Saravia on 11/7/24.
//

import Foundation

enum ServiceError: Error {
  case serverError(String)
}
