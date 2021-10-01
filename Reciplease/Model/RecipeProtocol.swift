//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by Romain Buewaert on 23/09/2021.
//

import Foundation

protocol RecipeProtocol {
    var recipeTitle: String { get }
    var recipeIngredientsList: String { get }
    var recipeIngredientsName: String { get }
    var recipeUrl: String { get }
    var recipeImageUrl: String { get }
    var recipeTime: Double { get }
    var recipeCuisineType: String { get }
    var recipeDishType: [String] { get }
}
