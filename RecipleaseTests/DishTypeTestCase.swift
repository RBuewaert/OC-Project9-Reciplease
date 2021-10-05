//
//  DishTypeTestCase.swift
//  RecipleaseTests
//
//  Created by Romain Buewaert on 30/09/2021.
//

import XCTest
@testable import Reciplease

class DishTypeTestCase: XCTestCase {
    let firstRecipeToSave = Recipe(title: "Recipe To Save",
                              imageUrl: "this is an image url", url: "this is the recipe url",
                              ingredientList: "detailed list of all ingredients",
                              ingredientName: "list of all ingredients name",
                              totalTime: 60.0, cuisineType: "american", dishType: ["main course"])
    let secondRecipeToSave = Recipe(title: "Recipe To Save2",
                              imageUrl: "this is an image url", url: "this is the recipe url",
                              ingredientList: "detailed list of all ingredients",
                              ingredientName: "list of all ingredients name",
                              totalTime: 50.0, cuisineType: "french", dishType: ["main course"])
    let firstExistingDishType = "dessert"
    let secondExistingDishType = "main course"

    func testSaveRecipeWithNewDishType_WhenCorrectValuesAreEntered_ThenShouldSaveRecipe() {
        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        XCTAssertNoThrow(try DishType().saveRecipe(firstRecipeToSave))

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

    func testSaveRecipeWithExistingDishType_WhenCorrectValuesAreEntered_ThenShouldSaveRecipe() {
        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let firstDishTypeToSave = DishType(context: context)
        firstDishTypeToSave.type = firstExistingDishType
        let secondDishTypeToSave = DishType(context: context)
        secondDishTypeToSave.type = secondExistingDishType

        XCTAssertNoThrow(try DishType().saveRecipe(firstRecipeToSave))

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

    func testRemoveRecipeWithExistingDishType_WhenCorrectValuesAreEntered_ThenShouldRemoveRecipe() {
        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let firstDishTypeToSave = DishType(context: context)
        firstDishTypeToSave.type = firstExistingDishType
        let secondDishTypeToSave = DishType(context: context)
        secondDishTypeToSave.type = secondExistingDishType

        do {
            try DishType().saveRecipe(firstRecipeToSave)
        } catch {
            print("Recipe not saved")
        }

        guard let recipeToRemove = DishType().returnExistingSavedRecipe(firstRecipeToSave) else { return }

        XCTAssertNoThrow(try DishType().removeSavedRecipe(recipeToRemove))

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

    func testReturnExistingSavedRecipe_WhenIncorrectRecipeIsSearched_ThenShouldReturnNil() {
        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let firstDishTypeToSave = DishType(context: context)
        firstDishTypeToSave.type = firstExistingDishType
        let secondDishTypeToSave = DishType(context: context)
        secondDishTypeToSave.type = secondExistingDishType

        do {
            try DishType().saveRecipe(firstRecipeToSave)
        } catch {
            print("Recipe not saved")
        }

        do {
            try DishType().saveRecipe(secondRecipeToSave)
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
        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        DishType.currentContext = context
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let firstDishTypeToSave = DishType(context: context)
        firstDishTypeToSave.type = firstExistingDishType
        let secondDishTypeToSave = DishType(context: context)
        secondDishTypeToSave.type = secondExistingDishType

        do {
            try DishType().saveRecipe(firstRecipeToSave)
        } catch {
            print("Recipe not saved")
        }

        do {
            try DishType().saveRecipe(secondRecipeToSave)
        } catch {
            print("Recipe not saved")
        }

        let recipeFind = DishType().returnExistingSavedRecipe(firstRecipeToSave)

        XCTAssertEqual(recipeFind?.recipeTitle, firstRecipeToSave.recipeTitle)
        XCTAssertEqual(recipeFind?.recipeImageUrl, firstRecipeToSave.recipeImageUrl)
        XCTAssertEqual(recipeFind?.recipeUrl, firstRecipeToSave.recipeUrl)
        XCTAssertEqual(recipeFind?.recipeIngredientsName, firstRecipeToSave.recipeIngredientsName)
        XCTAssertEqual(recipeFind?.recipeIngredientsList, firstRecipeToSave.recipeIngredientsList)
        XCTAssertEqual(recipeFind?.recipeTime, firstRecipeToSave.recipeTime)
        XCTAssertEqual(recipeFind?.recipeCuisineType, firstRecipeToSave.recipeCuisineType)
        XCTAssertEqual(recipeFind?.recipeDishType, firstRecipeToSave.recipeDishType)

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
}
