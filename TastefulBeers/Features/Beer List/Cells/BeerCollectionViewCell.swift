//
//  BeerCollectionViewCell.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/25/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "beer"
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var abvLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLayout()
    }
    
    private func initializeLayout() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        beerImage.sd_cancelCurrentImageLoad()
        beerName.text = ""
        abvLabel.text = ""
        beerImage.image = nil
    }
    
    func configure(with beer: Beer) {
        beerName.text = beer.name
        beerImage.loadImage(for: beer)
        let abvFormatter = NumberFormatter.abvFormatter
        abvLabel.text = "ABV: \(abvFormatter.string(from: NSNumber(value: beer.abv))!)"
    }
}
