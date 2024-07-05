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
  
  var viewModel: DetailViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
  }
  
  private func loadData() {
    if let data = viewModel {
      catImage.downloadImage(path: data.imagePath)
      collectionVIew.sourceList = data.tagCat
    }
  }
}
