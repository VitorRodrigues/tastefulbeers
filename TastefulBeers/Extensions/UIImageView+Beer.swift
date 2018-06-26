//
//  UIImageView+Beer.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/26/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(for beer: Beer) {
        sd_setImage(with: beer.imageUrl,
                    placeholderImage: #imageLiteral(resourceName: "placeholder"),
                    options: .continueInBackground) { (image, error, cacheType, url) in
                        guard error == nil else {
                            print("image load error: \(error!)")
                            return
                        }
        }
    }
    
    
}
