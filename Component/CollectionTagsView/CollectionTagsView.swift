//
//  CollectionTagsView.swift
//  Components
//
//  Created by Miguel Saravia on 5/7/24.
//

import UIKit
import Foundation

public class CollectionTagsView: UICollectionView, UICollectionViewDelegateFlowLayout {
  public var sourceList: [String] = []
  private let dispath = DispatchQueue.main
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    // Setup datasource and delegate.
    self.dataSource = self
    self.delegate = self
    // Register cell classes
    let bundle = Bundle(for: type(of: self))
    self.register(UINib(nibName: "TagCell", bundle: bundle), forCellWithReuseIdentifier: "TagCell")
    backgroundColor = .clear

    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 0
    layout.scrollDirection = .vertical
    collectionViewLayout = layout
    
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
  }
  
  // MARK: updateCollection
  public func updateCollection(dataList: [String]) {
    sourceList = dataList
    dispath.async {
      self.reloadData()
    }
  }
}

// MARK: UICollectionViewDataSource
extension CollectionTagsView: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sourceList.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCell else {
      return UICollectionViewCell()
    }
    
    // Configure the cell
    let tagName = sourceList[indexPath.row]
    cell.configCell(name: tagName)
    return cell
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CollectionTagsView {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    return CGSize(width: 90.0, height: 70.0)
  }
}
