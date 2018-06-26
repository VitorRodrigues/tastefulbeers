//
//  Beer.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/25/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import Foundation

class Beer: NSObject {
    
    let identifier: Int
    let name: String
    let abv: Float
    let ibu: Int
    
    let imageUrl: URL?
    let tagLine: String?
    let beerDescription: String?
    
    init(identifier: Int, name: String, abv: Float, ibu: Int) {
        self.identifier = identifier
        self.name = name
        self.abv = abv
        self.ibu = ibu
        self.imageUrl = nil
        self.tagLine = nil
        self.beerDescription = nil
        super.init()
    }
    
    init(identifier: Int, name: String, abv: Float, ibu: Int, imageUrl: URL?, tagLine: String?, description: String?) {
        self.identifier = identifier
        self.name = name
        self.abv = abv
        self.ibu = ibu
        self.imageUrl = imageUrl
        self.tagLine = tagLine
        self.beerDescription = description
        super.init()
    }
}
