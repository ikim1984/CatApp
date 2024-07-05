//
//  TagCell.swift
//  Components
//
//  Created by Miguel Saravia on 5/7/24.
//

import UIKit

class TagCell: UICollectionViewCell {
  
  @IBOutlet weak var titleTagLabel: UILabel!
  @IBOutlet weak var tagContainerView: UIView! {
    didSet {
      tagContainerView.layer.cornerRadius = 10
      tagContainerView.layer.masksToBounds = true
      
      tagContainerView.layer.borderColor = UIColor.gray.cgColor
      tagContainerView.layer.borderWidth = 1
      tagContainerView.layer.masksToBounds = false
      tagContainerView.clipsToBounds = false
      tagContainerView.backgroundColor = .systemOrange
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configCell(name: String) {
    titleTagLabel.text = name
  }
}
