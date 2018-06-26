//
//  NumberFormatter+Beer.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/26/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static var abvFormatter: NumberFormatter {
        let abvFormatter = NumberFormatter()
        abvFormatter.positiveSuffix = " %"
        abvFormatter.maximumFractionDigits = 1
        return abvFormatter
    }
}
