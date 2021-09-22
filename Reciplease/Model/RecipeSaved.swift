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
}
