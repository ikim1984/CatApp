//
//  CatListViewController.swift
//  CatsApp
//
//  Created by Miguel Saravia on 1/7/24.
//

import UIKit
import Networking

final class CatListViewController: UIViewController {
  //MARK:- Outlets
  @IBOutlet weak var catsCollectionView: CatsCollection!
 //MARK:- Variables
  let viewModel: ViewModelProtocol
  
  let limit = 50
  var skip = 0
  
  init(viewModel: ViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    let service = ApiService()
    viewModel = CatsListViewModel(apiService: service)
    super.init(coder: coder)
  }
  
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
    viewModel.fetchCats(limit: 20, skip: skip) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(response):
        let requestModel: [CatCellModel] = self.viewModel.handleModelCell(response: response)
        self.catsCollectionView.updateCollection(dataList: requestModel)
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}

//MARK:- Delegates
extension CatListViewController: CatsConfig {
  // MARK:- Delegate check if there is more data to load
  func checkLastId(isLast: Bool) {
    if isLast {
      skip += limit
      loadCats()
    }
  }
  
  func pushNavigation(data: CatCellModel) {
    let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailVC") as DetailViewController
    let viewModel = DetailViewModel(detailCat: data)
    detailController.viewModel = viewModel
    navigationController?.pushViewController(detailController, animated: true)
  }
}
