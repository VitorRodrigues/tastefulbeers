//
//  ViewController.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/25/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController, BeersDataSourceDelegate, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var requester: BeerRequester = BeerRequester()
    
    var dataSource = BeersCollectionDataSource()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        loadNextPage()
    }
    
    // MARK: - Methods
    private func loadNextPage() {
        guard !isLoadingShowing else { return } // Avoid creating parallel requests
        showLoading()
        requester.loadBeers(page) { (result) in
            switch result {
            case .failure(let error):
                self.showError(error)
                self.dataSource.notifyBottom = false
            case .success(let beers):
                self.receiveBeers(beers)
                self.dataSource.notifyBottom = true
            }
            self.hideLoading()
            self.page += 1
        }
    }
    
    private func receiveBeers(_ beers: [Beer]) {
        let indexPathes = dataSource.add(beers)
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexPathes)
        }, completion: nil)
    }
    
    // MARK: - Data Source Delegate
    func dataSourceReachedBottom(_ ds: BeersCollectionDataSource) {
        loadNextPage()
    }
    
    // MARK: - COLLECTION VIEW DELEGATE
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let beer = dataSource.item(at: indexPath),
            let vc = storyboard?.instantiateViewController(withIdentifier: "details") as? BeerDetailsViewController else { return }
        
        vc.beer = beer
        vc.title = beer.name
        self.show(vc, sender: nil)
    }
}

