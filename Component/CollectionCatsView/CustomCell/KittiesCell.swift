//
//  KittiesCell.swift
//  Components
//
//  Created by Miguel Saravia on 4/7/24.
//

import UIKit
import SDWebImage

class KittiesCell: UICollectionViewCell {
  // MARK:- Outlets
  @IBOutlet weak var catImage: UIImageView! {
    didSet {
      catImage.contentMode = .scaleAspectFill
      catImage.clipsToBounds = true
      catImage.sizeToFit()
    }
  }
  @IBOutlet weak var spinnerActivity: UIActivityIndicatorView! {
    didSet {
      spinnerActivity.hidesWhenStopped = true
      spinnerActivity.style = UIActivityIndicatorView.Style.large
      spinnerActivity.color = UIColor.white
      spinnerActivity.startAnimating()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    backgroundColor = .lightGray
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    catImage.image = nil
    spinnerActivity.startAnimating()
  }
  
  // MARK:- Setup Cell
  func configCell(data: CatCellModel) {
    catImage.downloadImage(path: data.image) { [weak self] status in
      if status {
        self?.spinnerActivity.stopAnimating()
      }
    }
  }
}
