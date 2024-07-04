//
//  CatListViewController.swift
//  CatsApp
//
//  Created by Miguel Saravia on 1/7/24.
//

import UIKit
import Components

final class CatListViewController: UIViewController {
  //MARK:- Outlets
  @IBOutlet weak var catsCollectionView: CatsCollection!
 //MARK:- Variables
  private let viewModel = CatsListViewModel()
  
  //MARK:- Livecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    loadCats()
  }
  
  //MARK:- Functions
  func loadCats() {
    viewModel.fetchCats(limit: 20, skip: 0) { result in
      switch result {
      case let .success(response):
        let requestModel: [CatRequest] = response.compactMap { CatRequest(image: $0.id ?? "", tag: $0.tags ?? []) }
        self.catsCollectionView.updateCollection(dataList: requestModel)
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}
