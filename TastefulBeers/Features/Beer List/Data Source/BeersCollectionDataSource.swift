//
//  BeersCollectionDataSource.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/25/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import UIKit


protocol BeersDataSourceDelegate {
    func dataSourceReachedBottom(_ ds: BeersCollectionDataSource)
}
/**
 Handle the data to show in a collectionv view
 */
class BeersCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    /// The collection of beers
    private var data: [Beer] = []
    
    /// Delegate to notify receive a message when the bottom was reached
    var delegate: BeersDataSourceDelegate?
    
    /// Flag that indicates if we should continue notifying when reached the bottom
    var notifyBottom = true
    
    
    /// Amount of data BEFORE the end in order for the datasource say it reached the bottom
    var threshold: Int = 5
    // MARK: - Methods
    
    /**
     Adds the beers to the data source
     - returns: A collection of IndexPathes representing were the items were added
     */
    func add(_ beers: [Beer]) -> [IndexPath] {
        let oldCount = data.count
        data.append(contentsOf: beers)
        let newCount = data.count
        let indexPathes = (oldCount..<newCount).map { IndexPath(item: $0, section: 0) }
        return indexPathes
    }
    
    /**
     Gets the beer model in the selected index path
     
     - parameter at: Indicates the position where the beer is
     - returns: The beer object if found in a valid position. `nil` otherwise.
     */
    func item(at indexPath: IndexPath) -> Beer? {
        guard indexPath.item < data.count && indexPath.item >= 0 else { return nil }
        return data[indexPath.item]
    }
    
    //MARK: - Collection view Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Since this is the only cell I have, it's safe to force casting
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.cellIdentifier, for: indexPath) as! BeerCollectionViewCell
        
        let beer = data[indexPath.row]
        cell.configure(with: beer)
        
        if notifyBottom && (indexPath.item + threshold) >= data.count {
            delegate?.dataSourceReachedBottom(self)
        }
        
        return cell
    }
    
}
