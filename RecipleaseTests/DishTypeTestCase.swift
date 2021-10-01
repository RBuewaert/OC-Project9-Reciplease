//
//  DishTypeTestCase.swift
//  RecipleaseTests
//
//  Created by Romain Buewaert on 30/09/2021.
//

import XCTest
@testable import Reciplease

class DishTypeTestCase: XCTestCase {
    func testSaveRecipe_WhenCorrectValuesAreEntered_ThenShouldSaveRecipe() {
        let recipeToSave = Recipe(title: "Chicken Vesuvio",
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
        
        DishType().saveRecipe(recipeToSave)
        
//        try! context.save()
        
        
//        let savedRecipe = try? DishType().addToRecipes(<#T##value: RecipeSaved##RecipeSaved#>)
//        
        waitForExpectations(timeout: 2.0) { error in
                XCTAssertNil(error, "Save did not occur")
            }
        
        
        
    }


    
    
    
}
