//
//  CollectionViewLayouts.swift
//  ADVA
//
//  Created by iOSAYed on 20/01/2024.
//

import Foundation
import UIKit

final class CollectionViewLayouts {
    static let shared = CollectionViewLayouts()
    
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
}
