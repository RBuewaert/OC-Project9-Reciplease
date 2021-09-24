//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by Romain Buewaert on 23/09/2021.
//

import Foundation

protocol RecipeProtocol {
    func recipeTitle() -> String
    func recipeIngredientsList() -> String
    func recipeIngredientsName() -> String
    func recipeUrl() -> String
    func recipeImageUrl() -> String
    func recipeNote() -> Double
    func recipeTime() -> Double
    func recipeCuisineType() -> String
    func recipeDishType() -> [String]
}
