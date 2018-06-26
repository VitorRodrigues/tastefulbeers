//
//  BeerRequester.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/25/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import Foundation
import Alamofire

/**
  Class containing the methods to make API calls to retrieve beer informations
 */
class BeerRequester: BaseRequester {
    
    /// The root path for beers
    let rootPath = "/beers"
    
    /**
     Retrieve a paginated list of beers
     - parameter page: The page of the request
     - parameter size: The maximum amount of the results in a request
     - parameter completion: Block of code to execute after the request generates a result
     
     - returns: The request object to manipulate the operation. `nil` if failed to create the request
     */
    @discardableResult
    func loadBeers(_ page: Int, size: Int = 20, completion: @escaping (Result<[Beer]>)->Void) -> Request? {
        guard page > 0 else {
            let error = APIError(code: APIError.invalidParameterErrorCode, localizedMessage: "Page must be greater than 0")
            completion(.failure(error))
            return nil
        }
        let path = rootPath
        let parameters = [
            "page": page,
            "per_page": size
        ]
        return performRequest(path: path,
                              method: .get,
                              parameters: parameters,
                              completion: { (jsonResult) in
                                switch jsonResult {
                                case .failure(let error): completion(.failure(error))
                                case .success(let json):
                                    let beers = json.arrayValue.compactMap { Beer(with: $0) }
                                    completion(.success(beers))
                                }
        })
    }
    
    /**
     Retrieve a single beer data
     
     - parameter identifier: The identifier of the desired beer
     - parameter completion: The block code that will execute when the request is done
     
     - returns: The request object to manipulate the operation
     */
    func loadBeer(with identifier: Int, completion: @escaping (Result<Beer>)->Void) -> Request? {
        let path = "\(rootPath)/\(identifier)"
        return performRequest(path: path,
                              method: .get,
                              parameters: nil,
                              completion: { (jsonResult) in
                                switch jsonResult {
                                case .failure(let error): completion(.failure(error))
                                case .success(let json):
                                    let beer = Beer(with: json)
                                    completion(.success(beer))
                                }
        })
    }
    
    
}
