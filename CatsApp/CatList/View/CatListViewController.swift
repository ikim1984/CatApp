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
  
  private let limit = 20
  private var skip = 0
  
  //MARK:- Livecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    catsCollectionView.collectionDelegate = self
    loadCats()
  }
  
  //MARK:- Functions
  func loadCats() {
    viewModel.fetchCats(limit: 20, skip: skip) { result in
      switch result {
      case let .success(response):
        let requestModel: [CatCellModel] = response.compactMap { CatCellModel(image: $0.id ?? "", 
                                                                              tag: $0.tags ?? []) }
        self.catsCollectionView.updateCollection(dataList: requestModel)
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}

extension CatListViewController: CatsConfig {
  func checkLastId(isLast: Bool) {
    skip += limit
    loadCats()
  }
  
  func onTapSelector(data: CatCellModel) {
    print("********* TAP SELECTED ***********\n", data)
  }
}
