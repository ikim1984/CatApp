//
//  Extension.swift
//  Components
//
//  Created by Miguel Saravia on 4/7/24.
//

import Networking
import SDWebImage
import UIKit

extension UIImageView {
  public func downloadImage(path: String, completion: @escaping (Bool) ->  Void = {_ in}) {
    let url = URL(string: FilePath.imagePthUrl + path)
    self.sd_setImage(with: url) { img, error, cache, url in
      if img != nil {
        completion(true)
      }
    }
  }
}
