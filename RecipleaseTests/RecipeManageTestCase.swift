//
//  RecipeManageTestCase.swift
//  RecipleaseTests
//
//  Created by Romain Buewaert on 27/09/2021.
//

import XCTest
@testable import Reciplease

class RecipeManageTestCase: XCTestCase {
    // MARK: - Test method GetFirstRecipe
    func testGetFirstRecipe_WhenNoDataIsReceveid_ThenShouldReturnError() {
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

    func testGetFirstRecipe_WhenIncorrectResponseIsReceveid_ThenShouldReturnError() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO,
                                                                   data: FakeResponseData.correctData))
        let recipeManage = RecipeManage(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeManage.getFirstRecipes(ingredients: "chicken") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipe method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFirstRecipe_WhenIncorrectDataIsReceveid_ThenShouldReturnError() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK,
                                                                   data: FakeResponseData.incorrectData))
        let recipeManage = RecipeManage(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeManage.getFirstRecipes(ingredients: "chicken") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipe method with incorrect data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFirstRecipe_WhencorrectDataIsReceveidWithNoResult_ThenShouldReturnNoResultToUser() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK,
                                                                data: FakeResponseData.correctDataWithNoResult))
        let recipeManage = RecipeManage(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeManage.getFirstRecipes(ingredients: "chicken") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipe method with correct data and no result failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFirstRecipe_WhencorrectDataIsReceveid_ThenShouldReturnSuccess() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK,
                                                                   data: FakeResponseData.correctData))
        let recipeManage = RecipeManage(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeManage.getFirstRecipes(ingredients: "chicken") { result in
            guard case .success(let data) = result else {
                XCTFail("Test getRecipe method with correct data failed.")
                return
            }
            // swiftlint:disable line_length
            XCTAssertNotNil(data)
            XCTAssertEqual(data.list.count, 20)
            XCTAssertEqual(data.list[0].title, "Chicken Vesuvio")
            XCTAssertEqual(data.list[0].imageUrl, "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg")
            XCTAssertEqual(data.list[0].url, "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html")
            XCTAssertEqual(data.list[0].yield, 4.0)
            XCTAssertEqual(data.list[0].ingredientList, "- 1/2 cup olive oil \n- 5 cloves garlic, peeled \n- 2 large russet potatoes, peeled and cut into chunks \n- 1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs) \n- 3/4 cup white wine \n- 3/4 cup chicken stock \n- 3 tablespoons chopped parsley \n- 1 tablespoon dried oregano \n- Salt and pepper \n- 1 cup frozen peas, thawed")
            XCTAssertEqual(data.list[0].ingredientName, "olive oil, garlic, russet potatoes, chicken, white wine, chicken stock, parsley, dried oregano, Salt, pepper, frozen peas")
            XCTAssertEqual(data.list[0].totalTime, 60.0)
            XCTAssertEqual(data.list[0].cuisineType, "american")
            XCTAssertEqual(data.list[0].dishType, ["main course"])
            XCTAssertEqual(RecipeManage.urlNextPage, "https://api.edamam.com/api/recipes/v2?q=chicken&app_key=2b6469119d2a85f1ca18276aae53b131&_cont=CHcVQBtNNQphDmgVQntAEX4BYldtBAAGRmxGC2ERYVJ2BwoVX3cVBWQSY1EhBQcGEmNHVmMTYFEgDQQCFTNJBGQUMQZxVhFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=06863309")
            expectation.fulfill()
            // swiftlint:enable line_length
        }
        wait(for: [expectation], timeout: 0.01)
    }

    // MARK: - Test method GetOtherRecipe
    func testGetOtherRecipe_WhencorrectDataIsReceveid_ThenShouldReturnSuccess() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK,
                                                                   data: FakeResponseData.correctData))
        let recipeManage = RecipeManage(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeManage.getOtherRecipes { result in
            guard case .success(let data) = result else {
                XCTFail("Test getRecipe method with correct data failed.")
                return
            }
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    // MARK: - Test method GetImage
    func testGetImage_WhenNoDataIsReceveid_ThenShouldReturnError() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let recipeManage = RecipeManage(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeManage.getImage(url:
                    "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getImage method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetImage_WhenCorrectDataIsReceveid_ThenShouldReturnSucces() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: nil, data: FakeResponseData.imageData))
        let recipeManage = RecipeManage(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        recipeManage.getImage(url:
                    "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg") { result in
            guard case .success(let data) = result else {
                XCTFail("Test getImage method with correct data failed.")
                return
            }
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
