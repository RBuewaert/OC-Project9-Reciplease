//
//  RecipeService.swift
//  Reciplease
//
//  Created by Romain Buewaert on 09/09/2021.
//

import Foundation
import Alamofire

final class RecipeService {
    // MARK: - Pattern Singleton
    static var shared = RecipeService()

    private static let url = "https://api.edamam.com/api/recipes/v2?"
    
    func getRecipe(ingredients: String, completionHandler: @escaping (Result<RecipeList, ErrorType>) -> ()) {
        let parameters = ["type": "public", "q": ingredients, "app_id": APIKey.id, "app_key": APIKey.key]

        AF.request(RecipeService.url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseDecodable(of: RecipeListResult.self) { response in

            guard response.error == nil else {
                return completionHandler(.failure(.downloadFailed))
            }

            guard let data = response.data else {
                return completionHandler(.failure(.noData))
            }
            
            var recipeList = RecipeList(list: [])
            do {
                let JSONresult = try JSONDecoder().decode(RecipeListResult.self, from: data)
                guard JSONresult.count > 0 else {
                    return completionHandler(.failure(.noResult))
                }
                recipeList = self.addRecipeOnArrayList(numberOfRecipe: JSONresult.to, JSONresult: JSONresult)
            } catch {
                print(error)
                return completionHandler(.failure(.extractValues))
            }
            
            
             // PB AVEC BEAUCOUP DE PAGES ET LIMITATION UTILISATION PAR MINUTE
//            while JSONresult.links != nil {
//
//
//                AF.request(JSONresult.links!.next.href).responseDecodable(of: RecipeListResult.self) { response in
//                    guard let data = response.data else {
//                        self.callback(nil, false, "The download failed")
//                        return
//                    }
//                    guard let JSONresult = try? JSONDecoder().decode(RecipeListResult.self, from: response.data!) else {
//                        self.callback(nil, nil, "")
//                        return
//                    }
//                    addRecipeOnArrayList(numberOfRecipe: JSONresult.to, JSONresult: JSONresult)
//                    print("RECIPE LIST \(RecipeService.recipeList.list.count)")
//                }
//            }
//            print("RECIPE LIST \(RecipeService.recipeList.list.count)")
            
            
            completionHandler(.success(recipeList))
        }
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
