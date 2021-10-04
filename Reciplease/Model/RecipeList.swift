//
//  RecipeList.swift
//  Reciplease
//
//  Created by Romain Buewaert on 10/09/2021.
//

import Foundation

// MARK: - Struct RecipeList and Recipe
struct RecipeList {
    var list: [Recipe]
}

struct Recipe {
    let title: String
    let imageUrl: String?
    let url: String
    let yield: Double
    let ingredientList: String
    let ingredientName: String
    let totalTime: Double
    let cuisineType: String
//    let mealType: [String]
    let dishType: [String]
}

extension Recipe: RecipeProtocol {
    var recipeTitle: String {
        return title
    }

    var recipeIngredientsList: String {
        return ingredientList
    }

    var recipeIngredientsName: String {
        return ingredientName
    }

    var recipeUrl: String {
        return url
    }

    var recipeImageUrl: String? {
        return imageUrl
    }

    var recipeTime: Double {
        return totalTime
    }

    var recipeCuisineType: String {
        return cuisineType
    }

    var recipeDishType: [String] {
        return dishType
    }
}

// MARK: - Struct result from JSON
struct RecipeListResult: Codable {
    let from: Int
    let to: Int
    let count: Int
    let links: RecipeListResultLinks
    let hits: [RecipeListResultHits]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

struct RecipeListResultLinks: Codable {
    let next: RecipeListResultLinksHref?
}

struct RecipeListResultLinksHref: Codable {
    let href: String
}

struct RecipeListResultHits: Codable {
    let recipe: RecipeListResultRecipe
}

extension RecipeListResultHits {
    func toRecipe() -> Recipe {
        return Recipe(title: recipe.label,
               imageUrl: recipe.image,
               url: recipe.url,
               yield: recipe.yield,
               ingredientList: addIngredientList(),
                ingredientName: addIngredientName(),
               totalTime: recipe.totalTime,
                cuisineType: addCuisineType(),
//               mealType: recipe.mealType,
                dishType: recipe.dishType ?? ["Unknown"])
    }

    private func addIngredientList() -> String {
        var ingredientlist = ""
        for ingredient in recipe.ingredientLines {
            ingredientlist.append("- \(ingredient) \n")
        }
        ingredientlist.removeLast(2)
        return ingredientlist
    }

    private func addIngredientName() -> String {
        var ingredients = ""
        for ingredient in recipe.ingredients {
            ingredients.append("\(ingredient.food), ")
        }
        ingredients.removeLast(2)
        return ingredients
    }

    private func addCuisineType() -> String {
        var cuisineType = ""
        for cuisine in recipe.cuisineType {
            cuisineType.append("\(cuisine), ")
        }
        cuisineType.removeLast(2)
        return cuisineType
    }
}

struct RecipeListResultRecipe: Codable {
    let label: String
    let image: String?
    let url: String
    let yield: Double
    let ingredientLines: [String]
    let ingredients: [RecipeListResultIngredient]
    let totalTime: Double
    let cuisineType: [String]
//    let mealType: [String]
    let dishType: [String]?
}

struct RecipeListResultIngredient: Codable {
    let food: String
}
