//
//  CatsCollection.swift
//  Components
//
//  Created by Miguel Saravia on 4/7/24.
//

import UIKit
import Foundation

public protocol CatsConfig: AnyObject {
  func checkLastId(isLast: Bool)
  func pushNavigation(data: CatCellModel)
}

public class CatsCollection: UICollectionView {
  public var sourceList: [CatCellModel] = []
  private let dispath = DispatchQueue.main
  weak public var collectionDelegate: CatsConfig?
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    // Setup datasource and delegate.
    self.dataSource = self
    self.delegate = self
    // Register cell classes
    let bundle = Bundle(for: type(of: self))
    self.register(UINib(nibName: "KittiesCell", bundle: bundle), forCellWithReuseIdentifier: "KittiesCell")
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 0
    collectionViewLayout = layout
  }
  
  // MARK: updateCollection
  public func updateCollection(dataList: [CatCellModel]) {
    sourceList.append(contentsOf: dataList)
    dispath.async {
      self.reloadData()
    }
  }
}

// MARK: UICollectionViewDataSource
extension CatsCollection: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sourceList.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KittiesCell", for: indexPath) as? KittiesCell else {
      return UICollectionViewCell()
    }
    // Configure the cell
    let catModel = sourceList[indexPath.row]
    cell.accessibilityIdentifier = "itemCat_\(catModel.image)"
    cell.catImage.accessibilityIdentifier = "Cat\(catModel.tag.joined(separator: ","))"
    cell.configCell(data: catModel)
    if catModel.image == sourceList.last?.image {
      collectionDelegate?.checkLastId(isLast: true)
    }
    return cell
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CatsCollection: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let catModel = sourceList[indexPath.row]
    collectionDelegate?.pushNavigation(data: catModel)
  }
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    return CGSize(width: (bounds.width / 2) - 20, height: 150.0)
  }
}
