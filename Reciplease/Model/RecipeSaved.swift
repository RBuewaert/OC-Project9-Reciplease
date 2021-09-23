//
//  RecipeSaved.swift
//  Reciplease
//
//  Created by Romain Buewaert on 20/09/2021.
//

import Foundation
import CoreData

class RecipeSaved: NSManagedObject {
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }

    public var wrappedImageUrl: String {
        imageUrl ?? "no Url"
    }

    public var wrappedIngredientList: String {
        ingredientList ?? "No Ingredients"
    }

    public var wrappedUrl: String {
        url ?? "No Url"
    }

    public var dishTypeArray: [DishType] {
        let set = dishTypes as? Set<DishType> ?? []
        return set.sorted {
            $0.wrappedType < $1.wrappedType
        }
    }
}

extension RecipeSaved: RecipeProtocol {
    func recipeTitle() -> String {
        return wrappedTitle
    }

    func recipeIngredientsList() -> String {
        return wrappedIngredientList
    }

    func recipeUrl() -> String {
        return wrappedUrl
    }

    func recipeImageUrl() -> String {
        return wrappedImageUrl
    }

    func recipeNote() -> Double {
        return note
    }

    func recipeTime() -> Double {
        return totalTime
    }

    func recipeDishType() -> [String] {
        var dishType = [String]()
        for type in dishTypeArray {
            dishType.append(type.wrappedType)
        }
        return dishType
    }
}
