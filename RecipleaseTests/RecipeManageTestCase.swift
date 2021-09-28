//
//  RecipeManageTestCase.swift
//  RecipleaseTests
//
//  Created by Romain Buewaert on 27/09/2021.
//

import XCTest
@testable import Reciplease

class RecipeManageTestCase: XCTestCase {
    func testGetRecipe_WhenNoDataIsReceveid_ThenShouldReturnNoData() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let recipeManage = RecipeManage(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeManage.getFirstRecipes(ingredients: "chicken") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipe method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
      
    
    


}
