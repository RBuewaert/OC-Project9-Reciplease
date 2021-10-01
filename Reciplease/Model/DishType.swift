//
//  DishType.swift
//  Reciplease
//
//  Created by Romain Buewaert on 20/09/2021.
//

import Foundation
import CoreData

final class DishType: NSManagedObject {
    // MARK: - Properties
    static var currentContext = AppDelegate.viewContext

    static var all: [DishType] {
        let request: NSFetchRequest<DishType> = DishType.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "type", ascending: true)
//            NSSortDescriptor(key: "type.recipes", ascending: true)
        ]
        guard let dishTypes = try? currentContext.fetch(request) else {
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

    // MARK: - Methods
    func saveRecipe(_ recipe: RecipeProtocol) throws {
        let recipeToSave = RecipeSaved(context: DishType.currentContext)
        recipeToSave.title = recipe.recipeTitle
        recipeToSave.imageUrl = recipe.recipeImageUrl
        recipeToSave.url = recipe.recipeUrl
        recipeToSave.ingredientList = recipe.recipeIngredientsList
        recipeToSave.ingredientName = recipe.recipeIngredientsName
        recipeToSave.totalTime = recipe.recipeTime
        recipeToSave.cuisineType = recipe.recipeCuisineType

        for dishType in recipe.recipeDishType {
            if !DishType().dishTypeIsExisting(dishType) {
                let dishTypeToSave = DishType(context: DishType.currentContext)
                dishTypeToSave.type = dishType
                recipeToSave.addToDishTypes(dishTypeToSave)
            } else {
                guard let currentDishType = DishType().returnExistingDishType(dishType) else { return }
                recipeToSave.addToDishTypes(currentDishType)
            }
        }

        do {
            try DishType.currentContext.save()
        } catch {
            throw ErrorType.saveFailed
        }
    }

    func removeSavedRecipe(_ recipe: RecipeSaved) throws {
        DishType.currentContext.delete(recipe)

        for dishType in recipe.dishTypeArray {
            recipe.removeFromDishTypes(dishType)

            if dishType.recipeArray.isEmpty {
                DishType.currentContext.delete(dishType)
            }
        }

        do {
            try DishType.currentContext.save()
        } catch {
            throw ErrorType.deletionFailed
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
                if recipe.title == recipeToVerify.title,
                   recipe.ingredientList == recipeToVerify.ingredientList,
                   recipe.url == recipeToVerify.url {
                    return true
                }
            }
        }
        return false
    }

    func returnExistingSavedRecipe(_ recipeToVerify: Recipe) -> RecipeSaved? {
        for dishType in DishType.all {
            for recipe in dishType.recipeArray {
                if recipe.title == recipeToVerify.title,
                   recipe.ingredientList == recipeToVerify.ingredientList,
                   recipe.url == recipeToVerify.url {
                    return recipe
                }
            }
        }
        return nil
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
