//
//  Extension+UICollectionView.swift
//  LoodosChallenge
//
//  Created by Oktay's Macbook on 8.11.2024.
//

import UIKit

extension UICollectionView {
    
    internal struct Cell {
        let cellClass: AnyClass?
        let reuseIdentifier: String
        
        init(cellClass: AnyClass? = nil, reuseIdentifier: String = "") {
            self.cellClass = cellClass
            self.reuseIdentifier = reuseIdentifier
        }
    }
    
    func registerCells(cells: [Cell] = [], headers: [Cell] = []) {
        cells.forEach { cell in
            self.register(cell.cellClass, forCellWithReuseIdentifier: cell.reuseIdentifier)
        }
        headers.forEach { cell in
            self.register(cell.cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cell.reuseIdentifier)
        }
    }
    
    func reloadThreadSafe() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
