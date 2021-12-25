//
//  SportsClubsCollectionViewDataSource.swift
//  Sports
//
//  Created by Lucas VERCELOT on 23/12/2021.
//

import Foundation
import UIKit
import Sports_Entities

protocol SportsClubsCollectionViewDataProvider: AnyObject {
    func getData() -> [SportClub]
}

class SportsClubsCollectionViewDataSource: NSObject {
    
    // MARK: - Vars
    
    private weak var collectionView: UICollectionView?
    private weak var dataProvider: SportsClubsCollectionViewDataProvider?

    // MARK: - Init
    
    init(collectionView: UICollectionView,
         dataProvider: SportsClubsCollectionViewDataProvider) {
        self.collectionView = collectionView
        self.dataProvider = dataProvider
        super.init()
        collectionView.dataSource = self
        registerCells()
    }
 
    // MARK: - Configure
    
    private func registerCells() {
        collectionView?.register(SportClubCollectionViewCell.self, forCellWithReuseIdentifier: "SportClubCollectionViewCell")
    }
}

// MARK: - UICollectionViewDataSource

extension SportsClubsCollectionViewDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider?.getData().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sportClub = dataProvider?.getData()[indexPath.row] else {
            return defaultCell()
        }
        
        return sportClubCell(with: sportClub, at: indexPath)
    }
    
    private func sportClubCell(with sportClub: SportClub, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let sportClubCell = collectionView?.dequeueReusableCell(withReuseIdentifier: "SportClubCollectionViewCell", for: indexPath) as? SportClubCollectionViewCell else {
            fatalError("Unable to create cell SportClubCollectionViewCell")
        }
        
        sportClubCell.configure(with: sportClub)
        
        return sportClubCell
    }
    
    private func defaultCell(title: String? = nil) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        cell.backgroundColor = .brown
        return cell
    }
}
