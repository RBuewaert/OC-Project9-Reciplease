//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Romain Buewaert on 27/09/2021.
//

import Foundation

final class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.apple.com")!,
                            statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.apple.com")!,
                            statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkError: Error {}
    static let networkError = NetworkError()

    static var correctData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "RecipeSearchAPI", withExtension: "json") else { return nil }
        do {
            return try Data(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    static var correctDataWithNoResult: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "RecipeSearchAPIWithNoResult", withExtension: "json") else {
            return nil }
        do {
            return try Data(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    static let incorrectData = "error".data(using: .utf8)!

    static let imageData = "image".data(using: .utf8)!
}
