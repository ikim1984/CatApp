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
  @IBOutlet weak var catsCollectionView: CatsCollection! {
    didSet {
      catsCollectionView.accessibilityIdentifier = "CatCollection"
    }
  }
  //MARK:- Variables
  let viewModel: ViewModelProtocol
  private var stopFetchingLimit = 1695
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
    navigationItem.customizationIdentifier = "homeTitle"
    navigationItem.title = "Best cats ever"
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  //MARK:- Functions
  func customAlert(message: String) {
    let alert = UIAlertController.alert(message: message)
    alert.view.accessibilityIdentifier = "CatAlert"
    present(alert, animated: true)
  }
  
  func loadCats() {
    viewModel.fetchCats(limit: 20, skip: skip) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(response):
        let requestModel: [CatCellModel] = self.viewModel.handleModelCell(response: response)
        self.catsCollectionView.updateCollection(dataList: requestModel)
      case let .failure(.serverError(message)):
        DispatchQueue.main.async {
          self.customAlert(message: message)
        }
      }
    }
  }
}

//MARK:- Delegates
extension CatListViewController: CatsConfig {
  // MARK:- Delegate check if there is more data to load
  func checkLastId(isLast: Bool) {
    if isLast && skip <= stopFetchingLimit {
      skip += limit
      loadCats()
    }
  }
  
  func pushNavigation(data: CatCellModel) {
    let viewModel = DetailViewModel(detailCat: data)
    
    guard let controller = storyboard?.instantiateViewController(
      identifier: "DetailVC",
      creator: { coder in
        DetailViewController(coder: coder)
      }
    ) else {
      return
    }
    
    controller.viewModel = viewModel
    
    navigationController?.pushViewController(controller, animated: true)
  }
}
