//
//  DetailViewModel.swift
//  CatsApp
//
//  Created by Miguel Saravia on 5/7/24.
//

import Foundation

protocol detailViewModelProtocol {
  var imagePath: String { get }
  var tagCat: [String] { get }
}

final class DetailViewModel: NSObject, detailViewModelProtocol {
  var detailCat: CatCellModel
  
  init(detailCat: CatCellModel) {
    self.detailCat = detailCat
  }
  
  var imagePath: String {
    detailCat.image
  }
  
  var tagCat: [String] {
    detailCat.tag
  }
}
