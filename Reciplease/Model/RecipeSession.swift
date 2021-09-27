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

    func requestForImage(url: String, completionHandler: @escaping (DataResponse<Data, AFError>) -> Void)
}

final class RecipeSession: NetworkSession {
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { dataResponse in
            completionHandler(dataResponse)
        }
    }

    func requestForImage(url: String, completionHandler: @escaping (DataResponse<Data, AFError>) -> Void) {
        AF.request(url).responseData { (dataImage) in
            completionHandler(dataImage)
        }
    }
}
