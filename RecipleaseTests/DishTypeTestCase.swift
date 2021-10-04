//
//  DishTypeTestCase.swift
//  RecipleaseTests
//
//  Created by Romain Buewaert on 30/09/2021.
//

import XCTest
@testable import Reciplease

class DishTypeTestCase: XCTestCase {
    func testSaveRecipeWithNewDishType_WhenCorrectValuesAreEntered_ThenShouldSaveRecipe() {
        let recipeToSave = Recipe(title: "Recipe To Save",
                                  imageUrl: "this is an image url",
                                  url: "this is the recipe url",
                                  ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 60.0,
                                  cuisineType: "american",
                                  dishType: ["main course"])

        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        XCTAssertNoThrow(try DishType().saveRecipe(recipeToSave))

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

    func testSaveRecipeWithExistingDishType_WhenCorrectValuesAreEntered_ThenShouldSaveRecipe() {
        let firstExistingDishType = "dessert"
        let secondExistingDishType = "main course"

        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let firstDishTypeToSave = DishType(context: context)
        firstDishTypeToSave.type = firstExistingDishType
        let secondDishTypeToSave = DishType(context: context)
        secondDishTypeToSave.type = secondExistingDishType

        let recipeToSave = Recipe(title: "Recipe To Save",
                                  imageUrl: "this is an image url",
                                  url: "this is the recipe url",
                                  ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 60.0,
                                  cuisineType: "american",
                                  dishType: ["main course, dessert"])

        XCTAssertNoThrow(try DishType().saveRecipe(recipeToSave))

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

    func testRemoveRecipeWithExistingDishType_WhenCorrectValuesAreEntered_ThenShouldRemoveRecipe() {
        let firstExistingDishType = "dessert"
        let secondExistingDishType = "main course"

        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let firstDishTypeToSave = DishType(context: context)
        firstDishTypeToSave.type = firstExistingDishType
        let secondDishTypeToSave = DishType(context: context)
        secondDishTypeToSave.type = secondExistingDishType

        let recipeToSave = Recipe(title: "Recipe To Save",
                                  imageUrl: "this is an image url",
                                  url: "this is the recipe url",
                                  ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 60.0,
                                  cuisineType: "american",
                                  dishType: ["main course, dessert"])
        do {
            try DishType().saveRecipe(recipeToSave)
        } catch {
            print("Recipe not saved")
        }

        guard let recipeToRemove = DishType().returnExistingSavedRecipe(recipeToSave) else { return }

        XCTAssertNoThrow(try DishType().removeSavedRecipe(recipeToRemove))

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

    func testReturnExistingSavedRecipe_WhenIncorrectRecipeIsSearched_ThenShouldReturnNil() {
        let firstExistingDishType = "dessert"
        let secondExistingDishType = "main course"

        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let firstDishTypeToSave = DishType(context: context)
        firstDishTypeToSave.type = firstExistingDishType
        let secondDishTypeToSave = DishType(context: context)
        secondDishTypeToSave.type = secondExistingDishType

        let recipeToSave1 = Recipe(title: "Recipe To Save",
                                  imageUrl: "this is an image url", url: "this is the recipe url",
                                  ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 60.0, cuisineType: "american", dishType: ["main course"])
        do {
            try DishType().saveRecipe(recipeToSave1)
        } catch {
            print("Recipe not saved")
        }

        let recipeToSave2 = Recipe(title: "Recipe To Save2",
                                  imageUrl: "this is an image url", url: "this is the recipe url",
                                  ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 50.0, cuisineType: "french", dishType: ["main course"])
        do {
            try DishType().saveRecipe(recipeToSave2)
        } catch {
            print("Recipe not saved")
        }

        let recipeToSearch = Recipe(title: "Recipe Unknown",
                                  imageUrl: "this is an image url",
                                  url: "this is the recipe url",
                                  ingredientList: "All ingredients",
                                  ingredientName: "list of all ingredients names",
                                  totalTime: 0.0,
                                  cuisineType: "american",
                                  dishType: ["main course"])

        XCTAssertNil(DishType().returnExistingSavedRecipe(recipeToSearch))

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

    func testReturnExistingSavedRecipe_WhenCorrectRecipeIsSearched_ThenShouldRecipeSaved() {
        let firstExistingDishType = "dessert"
        let secondExistingDishType = "main course"

        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let firstDishTypeToSave = DishType(context: context)
        firstDishTypeToSave.type = firstExistingDishType
        let secondDishTypeToSave = DishType(context: context)
        secondDishTypeToSave.type = secondExistingDishType

        let recipeToSave1 = Recipe(title: "Recipe To Save",
                                  imageUrl: "this is an image url", url: "this is the recipe url",
                                  ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 60.0, cuisineType: "american", dishType: ["main course"])
        do {
            try DishType().saveRecipe(recipeToSave1)
        } catch {
            print("Recipe not saved")
        }

        let recipeToSave2 = Recipe(title: "Recipe To Save2",
                                  imageUrl: "this is an image url", url: "this is the recipe url",
                                  ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 50.0, cuisineType: "french", dishType: ["main course"])
        do {
            try DishType().saveRecipe(recipeToSave2)
        } catch {
            print("Recipe not saved")
        }

        let recipeFind = DishType().returnExistingSavedRecipe(recipeToSave1)

        XCTAssertEqual(recipeFind?.recipeTitle, recipeToSave1.recipeTitle)
        XCTAssertEqual(recipeFind?.recipeImageUrl, recipeToSave1.recipeImageUrl)
        XCTAssertEqual(recipeFind?.recipeUrl, recipeToSave1.recipeUrl)
        XCTAssertEqual(recipeFind?.recipeIngredientsName, recipeToSave1.recipeIngredientsName)
        XCTAssertEqual(recipeFind?.recipeIngredientsList, recipeToSave1.recipeIngredientsList)
        XCTAssertEqual(recipeFind?.recipeTime, recipeToSave1.recipeTime)
        XCTAssertEqual(recipeFind?.recipeCuisineType, recipeToSave1.recipeCuisineType)
        XCTAssertEqual(recipeFind?.recipeDishType, recipeToSave1.recipeDishType)

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
}
