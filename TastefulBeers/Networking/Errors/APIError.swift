//
//  APIError.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 2/15/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import Foundation

class APIError: NSError {
    static let domain: String = "br.com.vitorrodrigues.work.pagseguro.TastefulBeers"
    
    static let unknownErrorCode: Int = -999
    static let invalidParameterErrorCode: Int = 650
    
    convenience init(code: Int, userInfo: [String: Any]? = nil) {
        self.init(domain: APIError.domain, code: code, userInfo: userInfo)
    }
    
    convenience init(code: Int, localizedMessage message: String) {
        self.init(code: code, userInfo: [NSLocalizedFailureReasonErrorKey: message])
    }
}
