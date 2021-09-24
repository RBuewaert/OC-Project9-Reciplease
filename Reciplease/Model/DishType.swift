//
//  DishType.swift
//  Reciplease
//
//  Created by Romain Buewaert on 20/09/2021.
//

import Foundation
import CoreData

final class DishType: NSManagedObject {
    static var all: [DishType] {
        let request: NSFetchRequest<DishType> = DishType.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "type", ascending: true)
//            NSSortDescriptor(key: "type.recipes", ascending: true)
        ]
        guard let dishTypes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return dishTypes
    }

    public var wrappedType: String {
        type ?? "No Type"
    }

    public var recipeArray: [RecipeSaved] {
        let set = recipes as? Set<RecipeSaved> ?? []
        return set.sorted {
            $0.wrappedTitle < $1.wrappedTitle
        }
    }

    func dishTypeIsExisting(_ dishTypeToVerify: String) -> Bool {
        for dishType in DishType.all {
            if dishType.type == dishTypeToVerify {
                return true
            }
        }
        return false
    }

    func recipeIsExisting(_ recipeToVerify: Recipe) -> Bool {
        for dishType in DishType.all {
            for recipe in dishType.recipeArray {
                if recipe.title == recipeToVerify.title, recipe.ingredientList == recipeToVerify.ingredientList, recipe.url == recipeToVerify.url {
                    return true
                }
            }
        }
        return false
    }

    func returnExistingDishType(_ dishTypeToVerify: String) -> DishType? {
        for dishType in DishType.all {
            if dishType.type ==  dishTypeToVerify {
                return dishType
            }
        }
        return nil
    }
}
