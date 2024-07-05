//
//  DetailViewController.swift
//  CatsApp
//
//  Created by Miguel Saravia on 4/7/24.
//

import UIKit

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
  
  var viewModel: DetailViewModel
  
  init(viewModel: DetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    let model = CatCellModel(image: "", tag: [])
    viewModel = DetailViewModel(detailCat: model)
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
  }
  
  private func loadData() {
    catImage.downloadImage(path: viewModel.imagePath)
    collectionVIew.sourceList = viewModel.tagCat
  }
}
