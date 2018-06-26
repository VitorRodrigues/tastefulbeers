//
//  BeerDetailsViewController.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/26/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import UIKit

class BeerDetailsViewController: UIViewController {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var ibuValue: UILabel!
    @IBOutlet weak var abvValue: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    /// Model for the view controller to render the data
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(beer != nil, "Beer must be passed to load `BeerDetailsViewController`")
        
        name.text = beer.name
        coverImage.loadImage(for: beer)
        tagLine.text = beer.tagLine
        abvValue.text = NumberFormatter.abvFormatter.string(from: NSNumber(value: beer.abv))
        ibuValue.text = "\(beer.ibu)"
        descriptionLabel.text = beer.beerDescription
        view.setNeedsLayout()
    }
}
