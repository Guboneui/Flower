//
//  PhoneNumberCollectionViewLayout.swift
//  DesignSystem
//
//  Created by 구본의 on 2023/10/25.
//

import UIKit

internal extension UICollectionView {
  func phoneNumberCollectionViewLayout() {
    
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(24)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(24)
    )
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 2
    section.contentInsets = .zero
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    self.collectionViewLayout = layout
  }
}
