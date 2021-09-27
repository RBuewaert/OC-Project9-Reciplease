//
//  RecipeService.swift
//  Reciplease
//
//  Created by Romain Buewaert on 09/09/2021.
//

import Foundation
import Alamofire

final class RecipeManage {
    // PAS UTILE
//    // MARK: - Pattern Singleton
//    static var shared = RecipeManage()

    private static let url = "https://api.edamam.com/api/recipes/v2?"
    static var urlNextPage = ""
    
    private let session: NetworkSession
    init(session: NetworkSession = RecipeSession()) {
        self.session = session
    }

    func getFirstRecipes(ingredients: String, completionHandler: @escaping (Result<RecipeList, ErrorType>) -> ()) {
        var url: URL? {
            var urlComponents = URLComponents(string: "https://api.edamam.com/api/recipes/v2?")

            urlComponents?.queryItems = [
                URLQueryItem(name: "type", value: "public"),
                URLQueryItem(name: "q", value: ingredients),
                URLQueryItem(name: "app_id", value: APIKey.id),
                URLQueryItem(name: "app_key", value: APIKey.key)
            ]

            guard let urlComponentUnwrapped = urlComponents else { return nil}
            guard let urlString = urlComponentUnwrapped.string else { return nil }
            guard let url = URL(string: urlString) else { return nil }
            return url
        }

        guard let urlUnwrapped = url else { return }

        session.request(url: urlUnwrapped) { dataResponse in
            self.getRecipe(dataResponse: dataResponse, completionHandler: completionHandler)
        }
    }
    
    func getOtherRecipes(completionHandler: @escaping (Result<RecipeList, ErrorType>) -> ()) {
        guard let url = URL(string: RecipeManage.urlNextPage) else { return }

        session.request(url: url) { dataResponse in
            self.getRecipe(dataResponse: dataResponse, completionHandler: completionHandler)
        }
    }

    private func getRecipe(dataResponse: DataResponse<Any, AFError>, completionHandler: @escaping (Result<RecipeList, ErrorType>) -> ()) {
        guard let data = dataResponse.data else {
            completionHandler(.failure(.noData))
            return
        }
        guard dataResponse.response?.statusCode == 200 else {
            completionHandler(.failure(.downloadFailed))
            return
        }

        var recipeList = RecipeList(list: [])
        do {
            let JSONresult = try JSONDecoder().decode(RecipeListResult.self, from: data)
            guard JSONresult.count > 0 else {
                return completionHandler(.failure(.noResult))
            }
            recipeList = self.addRecipeOnArrayList(numberOfRecipe: JSONresult.to, JSONresult: JSONresult)
            if let urlNextPage = JSONresult.links.next?.href {
                RecipeManage.urlNextPage = urlNextPage
            } else {
                RecipeManage.urlNextPage = ""
            }
        } catch {
            print(error)
            return completionHandler(.failure(.extractValues))
        }
        completionHandler(.success(recipeList))
    }

    private func addRecipeOnArrayList(numberOfRecipe: Int, JSONresult: RecipeListResult) -> RecipeList {
        var recipeList = RecipeList(list: [])
        let recipes = JSONresult.hits.map { $0.toRecipe() }
        recipeList.list.append(contentsOf: recipes)
        return recipeList
        
//         3 last lines equivalent to:
//        for hit in JSONresult.hits {
//            recipeList.list.append(hit.toRecipe())
//        }
//        return recipeList
    }

    func getImage(url: String, completionHandler: @escaping (Result<Data, ErrorType>) -> ()) {
        AF.request(url).responseData { (response) in
            guard response.error == nil else {
                completionHandler(.failure(.downloadFailed))
                return
            }

            guard let image = response.data else {
                completionHandler(.failure(.noData))
                return
            }

            completionHandler(.success(image))
        }
    }
}
