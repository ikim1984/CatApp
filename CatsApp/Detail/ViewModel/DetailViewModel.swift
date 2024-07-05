//
//  DetailViewModel.swift
//  CatsApp
//
//  Created by Miguel Saravia on 5/7/24.
//

import Foundation
import Components

final class DetailViewModel: NSObject {
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
