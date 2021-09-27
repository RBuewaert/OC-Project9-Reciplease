//
//  NetworkService.swift
//  Reciplease
//
//  Created by Romain Buewaert on 24/09/2021.
//

import Foundation
import Alamofire

protocol NetworkSession {
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void)
    
    
    
    
//    func request2(url: URL, completionHandler: @escaping (Result<RecipeList, ErrorType>) -> Void)
//
//
//    func get(_ url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
//
    
    

}

final class RecipeSession: NetworkSession {
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { dataResponse in
            completionHandler(dataResponse)
        }
    }
    
   
    
    
   
    
    
 
    
    
//    func request2(url: URL, completionHandler: @escaping (Result<RecipeList, ErrorType>) -> Void) {
//        <#code#>
//    }
//
//
//
//
//    func get(_ url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
//        AF.request(url)
//            .validate()
//            .responseData { response in
//                switch response.result {
//                case .failure(let error):
//                    completionHandler(nil, error)
//                case .success(let data):
//                    completionHandler(data, nil)
//                }
//            }
//    }
    
    
    
}
