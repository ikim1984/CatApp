//
//  DetailViewController.swift
//  CatsApp
//
//  Created by Miguel Saravia on 4/7/24.
//

import UIKit
import Components

final class DetailViewController: UIViewController {
  // Mark:- Outlets
  @IBOutlet weak var catImage: UIImageView! {
    didSet {
      catImage.contentMode = .scaleAspectFill
      catImage.clipsToBounds = true
      catImage.sizeToFit()
    }
  }
  @IBOutlet weak var collectionVIew: CollectionTagsView!
  
  var detailData: CatCellModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
  }
  
  private func loadData() {
    if let data = detailData {
      catImage.loadImage(image: data.image, id: data.image)
      collectionVIew.sourceList = data.tag
    }
  }
}
