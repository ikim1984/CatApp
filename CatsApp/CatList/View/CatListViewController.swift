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
  
  private let limit = 50
  private var skip = 0
  
  //MARK:- Livecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    catsCollectionView.collectionDelegate = self
    navigationSetup()
    loadCats()
  }
  
  //MARK:- Private functions
  private func navigationSetup() {
    navigationItem.title = "Best cats ever"
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
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

//MARK:- Delegates
extension CatListViewController: CatsConfig {
  func checkLastId(isLast: Bool) {
    skip += limit
    loadCats()
  }
  
  func pushNavigation(data: CatCellModel) {
    let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailVC") as DetailViewController
    let viewModel = DetailViewModel(detailCat: data)
    detailController.viewModel = viewModel
    navigationController?.pushViewController(detailController, animated: true)
  }
}
