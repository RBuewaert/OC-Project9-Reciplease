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
    static var recipeList = RecipeList(list: [])
    
    func getRecipe(ingredients: String, completionHandler: @escaping (Bool) -> ()) -> () {
        let parameters = ["type": "public", "q": ingredients, "app_id": APIKey.id, "app_key": APIKey.key]

        let request = AF.request("https://api.edamam.com/api/recipes/v2?", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseDecodable(of: RecipeListResult.self) { response in

            guard response.error == nil else {
                completionHandler(false)
                return
            }

            guard response.data != nil else {
                completionHandler(false)
                return
            }

            guard let JSONresult = try? JSONDecoder().decode(RecipeListResult.self, from: response.data!) else {
                completionHandler(false)
                return
            }

            self.addRecipeOnArrayList(numberOfRecipe: JSONresult.to, JSONresult: JSONresult)

            print("RECIPE LIST \(RecipeService.recipeList.list.count)")

            
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
            
            
            completionHandler(true)
        }
    }
    
    private func addRecipeOnArrayList(numberOfRecipe: Int, JSONresult: RecipeListResult) {
        for i in 0...(numberOfRecipe-1) {
            RecipeService.recipeList.list.append(Recipe(title: JSONresult.hits[i].recipe.label,
                                                    image: JSONresult.hits[i].recipe.image,
                                                    url: JSONresult.hits[i].recipe.url,
                                                    yield: JSONresult.hits[i].recipe.yield,
                                                    cautions: JSONresult.hits[i].recipe.cautions,
                                                    ingredientList: JSONresult.hits[i].recipe.ingredientLines,
                                                    totalTime: JSONresult.hits[i].recipe.totalTime,
                                                    mealType: JSONresult.hits[i].recipe.mealType,
                                                    dishType: JSONresult.hits[i].recipe.dishType))
        }
    }

    func getImage(url: String, completionHandler: @escaping (Bool, Data?) -> ()) -> () {
        let imageUrl = URL(string: url)
    
        AF.request(url).responseData { (response) in
            guard response.error == nil else {
                completionHandler(false, nil)
                return
            }

            guard let image = response.data else {
                completionHandler(false, nil)
                return
            }

            completionHandler(true, image)
        }
    }
}
