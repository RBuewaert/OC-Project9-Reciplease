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
                                  imageUrl: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                                  url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                                  yield: 4.0, ingredientList: "detailed list of all ingredients",
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
                                  imageUrl: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                                  url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                                  yield: 4.0, ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 60.0,
                                  cuisineType: "american",
                                  dishType: ["main course"])

        XCTAssertNoThrow(try DishType().saveRecipe(recipeToSave))

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

//    func testSaveRecipe_WhenIncorrectValuesAreEntered_ThenShouldSaveFailed() {
//        let recipeToSave: Recipe?
//
//        let context = TestCoreDataStack().persistentContainer.newBackgroundContext()
//        DishType.currentContext = context
//        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
//            return true
//        }
//
//        XCTAssertNoThrow(try DishType().saveRecipe(recipeToSave))
//
//        XCTAssertThrowsError(try DishType().saveRecipe(recipeToSave)) { (errorThrown) in
//               XCTAssertEqual(errorThrown as? ErrorType, ErrorType.saveFailed)
//        }
//
//        waitForExpectations(timeout: 2.0) { error in
//            XCTAssertNil(error, "Save did not occur")
//        }
//    }

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
                                  imageUrl: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                                  url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                                  yield: 4.0, ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 60.0,
                                  cuisineType: "american",
                                  dishType: ["main course"])
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
                                  yield: 4.0, ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 60.0, cuisineType: "american", dishType: ["main course"])
        do {
            try DishType().saveRecipe(recipeToSave1)
        } catch {
            print("Recipe not saved")
        }

        let recipeToSave2 = Recipe(title: "Recipe To Save2",
                                  imageUrl: "this is an image url", url: "this is the recipe url",
                                  yield: 5.0, ingredientList: "detailed list of all ingredients",
                                  ingredientName: "list of all ingredients name",
                                  totalTime: 50.0, cuisineType: "french", dishType: ["main course"])
        do {
            try DishType().saveRecipe(recipeToSave2)
        } catch {
            print("Recipe not saved")
        }

        let recipeToSearch = Recipe(title: "Recipe Unknown",
                                  imageUrl: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                                  url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                                  yield: 0.0, ingredientList: "All ingredients",
                                  ingredientName: "list of all ingredients names",
                                  totalTime: 0.0,
                                  cuisineType: "american",
                                  dishType: ["main course"])

        XCTAssertNil(DishType().returnExistingSavedRecipe(recipeToSearch))

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
}
