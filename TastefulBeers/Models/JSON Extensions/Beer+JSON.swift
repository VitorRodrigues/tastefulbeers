//
//  Beer+JSON.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/25/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Beer {
    convenience init(with json: JSON) {
        self.init(identifier: json["id"].intValue,
                  name: json["name"].stringValue,
                  abv: json["abv"].floatValue,
                  ibu: json["ibu"].intValue,
                  imageUrl: URL(string: json["image_url"].stringValue),
                  tagLine: json["tagline"].stringValue,
                  description: json["description"].stringValue)
        
    }
}

