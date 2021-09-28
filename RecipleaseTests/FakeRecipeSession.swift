//
//  FakeRecipeSession.swift
//  RecipleaseTests
//
//  Created by Romain Buewaert on 27/09/2021.
//

import Foundation
import Alamofire
@testable import Reciplease

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class FakeRecipeSession: NetworkSession {
    // MARK: - Properties
    private let fakeResponse: FakeResponse

    // MARK: - Initializer
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    // MARK: - Methods
    func request(url: URL, completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse<Any>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success("OK"))
        completionHandler(dataResponse)
    }

    func requestForImage(url: String, completionHandler: @escaping (DataResponse<Data, AFError>) -> Void) {
        let dataSucces = Data()
        let dataResponse = DataResponse<Data, AFError>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success(dataSucces))
        completionHandler(dataResponse)
    }
}
