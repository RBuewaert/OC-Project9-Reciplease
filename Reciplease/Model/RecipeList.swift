//
//  RecipeList.swift
//  Reciplease
//
//  Created by Romain Buewaert on 10/09/2021.
//

import Foundation

// MARK: - Struct RecipeList and Recipe
struct RecipeList {
    var list: [Recipe]
}

struct Recipe {
    let title: String
    let imageUrl: String?
    let url: String
    let yield: Double
//    let cautions: [String]
    let ingredientList : String
    let ingredientName: String
    let totalTime: Double
    let cuisineType: String
//    let mealType: [String]
    let dishType: [String]
}

extension Recipe: RecipeProtocol {
    var recipeTitle: String {
        return title
    }

    var recipeIngredientsList: String {
        return ingredientList
    }

    var recipeIngredientsName: String {
        return ingredientName
    }

    var recipeUrl: String {
        return url
    }

    var recipeImageUrl: String {
        return imageUrl ?? ""
    }

    var recipeNote: Double {
        return yield
    }

    var recipeTime: Double {
        return totalTime
    }

    var recipeCuisineType: String {
        return cuisineType
    }

    var recipeDishType: [String] {
        return dishType
    }
}

// MARK: - Struct result from JSON
struct RecipeListResult: Codable {
    let from: Int
    let to: Int
    let count: Int
    let links: RecipeListResultLinks
    let hits: [RecipeListResultHits]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

struct RecipeListResultLinks: Codable {
    let next: RecipeListResultLinksHref?
}

struct RecipeListResultLinksHref: Codable {
    let href: String
}

struct RecipeListResultHits: Codable {
    let recipe: RecipeListResultRecipe
}

extension RecipeListResultHits {
    func toRecipe() -> Recipe {
        return Recipe(title: recipe.label,
               imageUrl: recipe.image,
               url: recipe.url,
               yield: recipe.yield,
//               cautions: recipe.cautions,
               ingredientList: addIngredientList(),
                ingredientName: addIngredientName(),
               totalTime: recipe.totalTime,
                cuisineType: addCuisineType(),
//               mealType: recipe.mealType,
                dishType: recipe.dishType ?? ["Unknown"])
    }

    private func addIngredientList() -> String {
        var ingredientlist = ""
        for ingredient in recipe.ingredientLines {
            ingredientlist.append("- \(ingredient) \n")
        }
        ingredientlist.removeLast(2)
        return ingredientlist
    }

    private func addIngredientName() -> String {
        var ingredients = ""
        for ingredient in recipe.ingredients {
            ingredients.append("\(ingredient.food), ")
        }
        ingredients.removeLast(2)
        return ingredients
    }

    private func addCuisineType() -> String {
        var cuisineType = ""
        for cuisine in recipe.cuisineType {
            cuisineType.append("\(cuisine), ")
        }
        cuisineType.removeLast(2)
        return cuisineType
    }
}

struct RecipeListResultRecipe: Codable {
    let label: String
    let image: String?
    let url: String
    let yield: Double
//    let cautions: [String]
    let ingredientLines : [String]
    let ingredients : [RecipeListResultIngredient]
    let totalTime: Double
    let cuisineType : [String]
//    let mealType: [String]
    let dishType: [String]?
}

struct RecipeListResultIngredient: Codable {
    let food: String
}






/*
 
 research
 keyNotFound(CodingKeys(stringValue: "dishType", intValue: nil), Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "hits", intValue: nil), _JSONKey(stringValue: "Index 3", intValue: 3), CodingKeys(stringValue: "recipe", intValue: nil)], debugDescription: "No value associated with key CodingKeys(stringValue: \"dishType\", intValue: nil) (\"dishType\").", underlyingError: nil))
 
 
 
 
 
 SHRIMP RESEARCH
 {
     "from": 1,
     "to": 20,
     "count": 10000,
     "_links": {
         "next": {
             "href": "https://api.edamam.com/api/recipes/v2?q=shrimp&app_key=2b6469119d2a85f1ca18276aae53b131&_cont=CHcVQBtNNQphDmgVQntAEX4BYVVtAAsBQmdIAGAVZ1R1BAICUXlSCmdGMlxzBVUHETFHUGcTZFV7UAMBQTRBAzQbYlJ0VwIVLnlSVSBMPkd5BgMbUSYRVTdgMgksRlpSAAcRXTVGcV84SU4%3D&type=public&app_id=06863309",
             "title": "Next page"
         }
     },
     "hits": [
         {
             "recipe": {
                 "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_6f117fdb48ed251ba44f2b5782f25068",
                 "label": "Quick, Concentrated Shrimp Stock",
                 "image": "https://www.edamam.com/web-img/4df/4df9373881c1e3a92dff4e4d940068c8",
                 "source": "Martha Stewart",
                 "url": "https://www.marthastewart.com/1544219/quick-concentrated-shrimp-stock",
                 "shareAs": "http://www.edamam.com/recipe/quick-concentrated-shrimp-stock-6f117fdb48ed251ba44f2b5782f25068/shrimp",
                 "yield": 2.0,
                 "dietLabels": [
                     "High-Protein",
                     "Low-Fat",
                     "Low-Carb",
                     "Low-Sodium"
                 ],
                 "healthLabels": [
                     "Sugar-Conscious",
                     "Low Potassium",
                     "Kidney-Friendly",
                     "Keto-Friendly",
                     "Pescatarian",
                     "Mediterranean",
                     "DASH",
                     "Dairy-Free",
                     "Gluten-Free",
                     "Wheat-Free",
                     "Egg-Free",
                     "Peanut-Free",
                     "Tree-Nut-Free",
                     "Soy-Free",
                     "Fish-Free",
                     "Pork-Free",
                     "Red-Meat-Free",
                     "Celery-Free",
                     "Mustard-Free",
                     "Sesame-Free",
                     "Lupine-Free",
                     "Mollusk-Free",
                     "Alcohol-Free",
                     "No oil added",
                     "Immuno-Supportive"
                 ],
                 "cautions": [],
                 "ingredientLines": [
                     "Shrimp shells, from 1 pound large shrimp",
                     "1 clove garlic"
                 ],
                 "ingredients": [
                     {
                         "text": "Shrimp shells, from 1 pound large shrimp",
                         "quantity": 1.0,
                         "measure": "pound",
                         "food": "Shrimp",
                         "weight": 453.59237,
                         "foodCategory": "seafood",
                         "foodId": "food_b38bejhbq9loe2bbb7bnmbcpteft",
                         "image": "https://www.edamam.com/food-img/ebe/ebe2888b894f48d19762e1d606db0206.jpg"
                     },
                     {
                         "text": "1 clove garlic",
                         "quantity": 1.0,
                         "measure": "clove",
                         "food": "garlic",
                         "weight": 3.0,
                         "foodCategory": "vegetables",
                         "foodId": "food_avtcmx6bgjv1jvay6s6stan8dnyp",
                         "image": "https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg"
                     }
                 ],
                 "calories": 13.060823308000002,
                 "totalWeight": 18.263694800000003,
                 "totalTime": 5.0,
                 "cuisineType": [
                     "italian"
                 ],
                 "mealType": [
                     "lunch/dinner"
                 ],
                 "dishType": [
                     "soup"
                 ],
                 "totalNutrients": {
                     "ENERC_KCAL": {
                         "label": "Energy",
                         "quantity": 13.060823308000002,
                         "unit": "kcal"
                     },
                     "FAT": {
                         "label": "Fat",
                         "quantity": 0.18385131748,
                         "unit": "g"
                     },
                     "FASAT": {
                         "label": "Saturated",
                         "quantity": 0.047461843428,
                         "unit": "g"
                     },
                     "FATRN": {
                         "label": "Trans",
                         "quantity": 0.003265865064,
                         "unit": "g"
                     },
                     "FAMS": {
                         "label": "Monounsaturated",
                         "quantity": 0.032853287588,
                         "unit": "g"
                     },
                     "FAPU": {
                         "label": "Polyunsaturated",
                         "quantity": 0.05382269966,
                         "unit": "g"
                     },
                     "CHOCDF": {
                         "label": "Carbs",
                         "quantity": 0.20477962268,
                         "unit": "g"
                     },
                     "FIBTG": {
                         "label": "Fiber",
                         "quantity": 0.0025199999999999997,
                         "unit": "g"
                     },
                     "SUGAR": {
                         "label": "Sugars",
                         "quantity": 0.0012,
                         "unit": "g"
                     },
                     "PROCNT": {
                         "label": "Protein",
                         "quantity": 2.4769888622800003,
                         "unit": "g"
                     },
                     "CHOLE": {
                         "label": "Cholesterol",
                         "quantity": 22.861055448000002,
                         "unit": "mg"
                     },
                     "NA": {
                         "label": "Sodium",
                         "quantity": 102.713712568,
                         "unit": "mg"
                     },
                     "CA": {
                         "label": "Calcium",
                         "quantity": 10.014795192000001,
                         "unit": "mg"
                     },
                     "MG": {
                         "label": "Magnesium",
                         "quantity": 4.021612856,
                         "unit": "mg"
                     },
                     "K": {
                         "label": "Potassium",
                         "quantity": 20.983575124,
                         "unit": "mg"
                     },
                     "FE": {
                         "label": "Iron",
                         "quantity": 0.04014175908,
                         "unit": "mg"
                     },
                     "ZN": {
                         "label": "Zinc",
                         "quantity": 0.17738583956,
                         "unit": "mg"
                     },
                     "P": {
                         "label": "Phosphorus",
                         "quantity": 44.454215312,
                         "unit": "mg"
                     },
                     "VITA_RAE": {
                         "label": "Vitamin A",
                         "quantity": 9.797595192000001,
                         "unit": "µg"
                     },
                     "VITC": {
                         "label": "Vitamin C",
                         "quantity": 0.037439999999999994,
                         "unit": "mg"
                     },
                     "THIA": {
                         "label": "Thiamin (B1)",
                         "quantity": 0.0038687389600000005,
                         "unit": "mg"
                     },
                     "RIBF": {
                         "label": "Riboflavin (B2)",
                         "quantity": 0.0028535542200000003,
                         "unit": "mg"
                     },
                     "NIA": {
                         "label": "Niacin (B3)",
                         "quantity": 0.323434893544,
                         "unit": "mg"
                     },
                     "VITB6A": {
                         "label": "Vitamin B6",
                         "quantity": 0.030693348628000005,
                         "unit": "mg"
                     },
                     "FOLDFE": {
                         "label": "Folate equivalent (total)",
                         "quantity": 3.4509020120000002,
                         "unit": "µg"
                     },
                     "FOLFD": {
                         "label": "Folate (food)",
                         "quantity": 3.4509020120000002,
                         "unit": "µg"
                     },
                     "FOLAC": {
                         "label": "Folic acid",
                         "quantity": 0.0,
                         "unit": "µg"
                     },
                     "VITB12": {
                         "label": "Vitamin B12",
                         "quantity": 0.20139501228000004,
                         "unit": "µg"
                     },
                     "VITD": {
                         "label": "Vitamin D",
                         "quantity": 0.018143694800000002,
                         "unit": "µg"
                     },
                     "TOCPHA": {
                         "label": "Vitamin E",
                         "quantity": 0.23959277136000004,
                         "unit": "mg"
                     },
                     "VITK1": {
                         "label": "Vitamin K",
                         "quantity": 0.0564710844,
                         "unit": "µg"
                     },
                     "WATER": {
                         "label": "Water",
                         "quantity": 15.131377053480003,
                         "unit": "g"
                     }
                 },
                 "totalDaily": {
                     "ENERC_KCAL": {
                         "label": "Energy",
                         "quantity": 0.6530411654000001,
                         "unit": "%"
                     },
                     "FAT": {
                         "label": "Fat",
                         "quantity": 0.2828481807384615,
                         "unit": "%"
                     },
                     "FASAT": {
                         "label": "Saturated",
                         "quantity": 0.23730921714000003,
                         "unit": "%"
                     },
                     "CHOCDF": {
                         "label": "Carbs",
                         "quantity": 0.06825987422666667,
                         "unit": "%"
                     },
                     "FIBTG": {
                         "label": "Fiber",
                         "quantity": 0.010079999999999999,
                         "unit": "%"
                     },
                     "PROCNT": {
                         "label": "Protein",
                         "quantity": 4.9539777245600005,
                         "unit": "%"
                     },
                     "CHOLE": {
                         "label": "Cholesterol",
                         "quantity": 7.620351816,
                         "unit": "%"
                     },
                     "NA": {
                         "label": "Sodium",
                         "quantity": 4.279738023666667,
                         "unit": "%"
                     },
                     "CA": {
                         "label": "Calcium",
                         "quantity": 1.0014795192000001,
                         "unit": "%"
                     },
                     "MG": {
                         "label": "Magnesium",
                         "quantity": 0.9575268704761905,
                         "unit": "%"
                     },
                     "K": {
                         "label": "Potassium",
                         "quantity": 0.44645904519148943,
                         "unit": "%"
                     },
                     "FE": {
                         "label": "Iron",
                         "quantity": 0.22300977266666663,
                         "unit": "%"
                     },
                     "ZN": {
                         "label": "Zinc",
                         "quantity": 1.6125985414545454,
                         "unit": "%"
                     },
                     "P": {
                         "label": "Phosphorus",
                         "quantity": 6.3506021874285725,
                         "unit": "%"
                     },
                     "VITA_RAE": {
                         "label": "Vitamin A",
                         "quantity": 1.0886216880000001,
                         "unit": "%"
                     },
                     "VITC": {
                         "label": "Vitamin C",
                         "quantity": 0.04159999999999999,
                         "unit": "%"
                     },
                     "THIA": {
                         "label": "Thiamin (B1)",
                         "quantity": 0.32239491333333337,
                         "unit": "%"
                     },
                     "RIBF": {
                         "label": "Riboflavin (B2)",
                         "quantity": 0.2195041707692308,
                         "unit": "%"
                     },
                     "NIA": {
                         "label": "Niacin (B3)",
                         "quantity": 2.02146808465,
                         "unit": "%"
                     },
                     "VITB6A": {
                         "label": "Vitamin B6",
                         "quantity": 2.3610268175384617,
                         "unit": "%"
                     },
                     "FOLDFE": {
                         "label": "Folate equivalent (total)",
                         "quantity": 0.8627255030000001,
                         "unit": "%"
                     },
                     "VITB12": {
                         "label": "Vitamin B12",
                         "quantity": 8.391458845000002,
                         "unit": "%"
                     },
                     "VITD": {
                         "label": "Vitamin D",
                         "quantity": 0.12095796533333335,
                         "unit": "%"
                     },
                     "TOCPHA": {
                         "label": "Vitamin E",
                         "quantity": 1.5972851424000003,
                         "unit": "%"
                     },
                     "VITK1": {
                         "label": "Vitamin K",
                         "quantity": 0.047059237000000004,
                         "unit": "%"
                     }
                 },
                 "digest": [
                     {
                         "label": "Fat",
                         "tag": "FAT",
                         "schemaOrgTag": "fatContent",
                         "total": 0.18385131748,
                         "hasRDI": true,
                         "daily": 0.2828481807384615,
                         "unit": "g",
                         "sub": [
                             {
                                 "label": "Saturated",
                                 "tag": "FASAT",
                                 "schemaOrgTag": "saturatedFatContent",
                                 "total": 0.047461843428,
                                 "hasRDI": true,
                                 "daily": 0.23730921714000003,
                                 "unit": "g"
                             },
                             {
                                 "label": "Trans",
                                 "tag": "FATRN",
                                 "schemaOrgTag": "transFatContent",
                                 "total": 0.003265865064,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Monounsaturated",
                                 "tag": "FAMS",
                                 "schemaOrgTag": null,
                                 "total": 0.032853287588,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Polyunsaturated",
                                 "tag": "FAPU",
                                 "schemaOrgTag": null,
                                 "total": 0.05382269966,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             }
                         ]
                     },
                     {
                         "label": "Carbs",
                         "tag": "CHOCDF",
                         "schemaOrgTag": "carbohydrateContent",
                         "total": 0.20477962268,
                         "hasRDI": true,
                         "daily": 0.06825987422666667,
                         "unit": "g",
                         "sub": [
                             {
                                 "label": "Carbs (net)",
                                 "tag": "CHOCDF.net",
                                 "schemaOrgTag": null,
                                 "total": 0.0,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Fiber",
                                 "tag": "FIBTG",
                                 "schemaOrgTag": "fiberContent",
                                 "total": 0.0025199999999999997,
                                 "hasRDI": true,
                                 "daily": 0.010079999999999999,
                                 "unit": "g"
                             },
                             {
                                 "label": "Sugars",
                                 "tag": "SUGAR",
                                 "schemaOrgTag": "sugarContent",
                                 "total": 0.0012,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Sugars, added",
                                 "tag": "SUGAR.added",
                                 "schemaOrgTag": null,
                                 "total": 0.0,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             }
                         ]
                     },
                     {
                         "label": "Protein",
                         "tag": "PROCNT",
                         "schemaOrgTag": "proteinContent",
                         "total": 2.4769888622800003,
                         "hasRDI": true,
                         "daily": 4.9539777245600005,
                         "unit": "g"
                     },
                     {
                         "label": "Cholesterol",
                         "tag": "CHOLE",
                         "schemaOrgTag": "cholesterolContent",
                         "total": 22.861055448000002,
                         "hasRDI": true,
                         "daily": 7.620351816,
                         "unit": "mg"
                     },
                     {
                         "label": "Sodium",
                         "tag": "NA",
                         "schemaOrgTag": "sodiumContent",
                         "total": 102.713712568,
                         "hasRDI": true,
                         "daily": 4.279738023666667,
                         "unit": "mg"
                     },
                     {
                         "label": "Calcium",
                         "tag": "CA",
                         "schemaOrgTag": null,
                         "total": 10.014795192000001,
                         "hasRDI": true,
                         "daily": 1.0014795192000001,
                         "unit": "mg"
                     },
                     {
                         "label": "Magnesium",
                         "tag": "MG",
                         "schemaOrgTag": null,
                         "total": 4.021612856,
                         "hasRDI": true,
                         "daily": 0.9575268704761905,
                         "unit": "mg"
                     },
                     {
                         "label": "Potassium",
                         "tag": "K",
                         "schemaOrgTag": null,
                         "total": 20.983575124,
                         "hasRDI": true,
                         "daily": 0.44645904519148943,
                         "unit": "mg"
                     },
                     {
                         "label": "Iron",
                         "tag": "FE",
                         "schemaOrgTag": null,
                         "total": 0.04014175908,
                         "hasRDI": true,
                         "daily": 0.22300977266666663,
                         "unit": "mg"
                     },
                     {
                         "label": "Zinc",
                         "tag": "ZN",
                         "schemaOrgTag": null,
                         "total": 0.17738583956,
                         "hasRDI": true,
                         "daily": 1.6125985414545454,
                         "unit": "mg"
                     },
                     {
                         "label": "Phosphorus",
                         "tag": "P",
                         "schemaOrgTag": null,
                         "total": 44.454215312,
                         "hasRDI": true,
                         "daily": 6.3506021874285725,
                         "unit": "mg"
                     },
                     {
                         "label": "Vitamin A",
                         "tag": "VITA_RAE",
                         "schemaOrgTag": null,
                         "total": 9.797595192000001,
                         "hasRDI": true,
                         "daily": 1.0886216880000001,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin C",
                         "tag": "VITC",
                         "schemaOrgTag": null,
                         "total": 0.037439999999999994,
                         "hasRDI": true,
                         "daily": 0.04159999999999999,
                         "unit": "mg"
                     },
                     {
                         "label": "Thiamin (B1)",
                         "tag": "THIA",
                         "schemaOrgTag": null,
                         "total": 0.0038687389600000005,
                         "hasRDI": true,
                         "daily": 0.32239491333333337,
                         "unit": "mg"
                     },
                     {
                         "label": "Riboflavin (B2)",
                         "tag": "RIBF",
                         "schemaOrgTag": null,
                         "total": 0.0028535542200000003,
                         "hasRDI": true,
                         "daily": 0.2195041707692308,
                         "unit": "mg"
                     },
                     {
                         "label": "Niacin (B3)",
                         "tag": "NIA",
                         "schemaOrgTag": null,
                         "total": 0.323434893544,
                         "hasRDI": true,
                         "daily": 2.02146808465,
                         "unit": "mg"
                     },
                     {
                         "label": "Vitamin B6",
                         "tag": "VITB6A",
                         "schemaOrgTag": null,
                         "total": 0.030693348628000005,
                         "hasRDI": true,
                         "daily": 2.3610268175384617,
                         "unit": "mg"
                     },
                     {
                         "label": "Folate equivalent (total)",
                         "tag": "FOLDFE",
                         "schemaOrgTag": null,
                         "total": 3.4509020120000002,
                         "hasRDI": true,
                         "daily": 0.8627255030000001,
                         "unit": "µg"
                     },
                     {
                         "label": "Folate (food)",
                         "tag": "FOLFD",
                         "schemaOrgTag": null,
                         "total": 3.4509020120000002,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "µg"
                     },
                     {
                         "label": "Folic acid",
                         "tag": "FOLAC",
                         "schemaOrgTag": null,
                         "total": 0.0,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin B12",
                         "tag": "VITB12",
                         "schemaOrgTag": null,
                         "total": 0.20139501228000004,
                         "hasRDI": true,
                         "daily": 8.391458845000002,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin D",
                         "tag": "VITD",
                         "schemaOrgTag": null,
                         "total": 0.018143694800000002,
                         "hasRDI": true,
                         "daily": 0.12095796533333335,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin E",
                         "tag": "TOCPHA",
                         "schemaOrgTag": null,
                         "total": 0.23959277136000004,
                         "hasRDI": true,
                         "daily": 1.5972851424000003,
                         "unit": "mg"
                     },
                     {
                         "label": "Vitamin K",
                         "tag": "VITK1",
                         "schemaOrgTag": null,
                         "total": 0.0564710844,
                         "hasRDI": true,
                         "daily": 0.047059237000000004,
                         "unit": "µg"
                     },
                     {
                         "label": "Sugar alcohols",
                         "tag": "Sugar.alcohol",
                         "schemaOrgTag": null,
                         "total": 0.0,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "g"
                     },
                     {
                         "label": "Water",
                         "tag": "WATER",
                         "schemaOrgTag": null,
                         "total": 15.131377053480003,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "g"
                     }
                 ]
             },
             "_links": {
                 "self": {
                     "href": "https://api.edamam.com/api/recipes/v2/6f117fdb48ed251ba44f2b5782f25068?type=public&app_id=06863309&app_key=2b6469119d2a85f1ca18276aae53b131",
                     "title": "Self"
                 }
             }
         },
         {
             "recipe": {
                 "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_cef01492d6d05acfececabd05bfcc492",
                 "label": "Piri Piri Shrimp",
                 "image": "https://www.edamam.com/web-img/eae/eae15af90c18201882693468060c4329.jpg",
                 "source": "Serious Eats",
                 "url": "http://www.seriouseats.com/recipes/2011/11/piri-piri-shrimp-recipe.html",
                 "shareAs": "http://www.edamam.com/recipe/piri-piri-shrimp-cef01492d6d05acfececabd05bfcc492/shrimp",
                 "yield": 4.0,
                 "dietLabels": [
                     "Low-Carb"
                 ],
                 "healthLabels": [
                     "Sugar-Conscious",
 
 
 
 
 
 
 
 
 
 
 
 CHICKEN RESEARCH
 {
     "from": 1,
     "to": 20,
     "count": 10000,
     "_links": {
         "next": {
             "href": "https://api.edamam.com/api/recipes/v2?q=chicken&app_key=2b6469119d2a85f1ca18276aae53b131&_cont=CHcVQBtNNQphDmgVQntAEX4BYldtBAAGRmxGC2ERYVJ2BwoVX3cVBWQSY1EhBQcGEmNHVmMTYFEgDQQCFTNJBGQUMQZxVhFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=06863309",
             "title": "Next page"
         }
     },
     "hits": [
         {
             "recipe": {
                 "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6",
                 "label": "Chicken Vesuvio",
                 "image": "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                 "source": "Serious Eats",
                 "url": "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                 "shareAs": "http://www.edamam.com/recipe/chicken-vesuvio-b79327d05b8e5b838ad6cfd9576b30b6/chicken",
                 "yield": 4.0,
                 "dietLabels": [
                     "Low-Carb"
                 ],
                 "healthLabels": [
                     "Mediterranean",
                     "Dairy-Free",
                     "Gluten-Free",
                     "Wheat-Free",
                     "Egg-Free",
                     "Peanut-Free",
                     "Tree-Nut-Free",
                     "Soy-Free",
                     "Fish-Free",
                     "Shellfish-Free",
                     "Pork-Free",
                     "Red-Meat-Free",
                     "Crustacean-Free",
                     "Celery-Free",
                     "Mustard-Free",
                     "Sesame-Free",
                     "Lupine-Free",
                     "Mollusk-Free",
                     "Kosher"
                 ],
                 "cautions": [
                     "Sulfites"
                 ],
                 "ingredientLines": [
                     "1/2 cup olive oil",
                     "5 cloves garlic, peeled",
                     "2 large russet potatoes, peeled and cut into chunks",
                     "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
                     "3/4 cup white wine",
                     "3/4 cup chicken stock",
                     "3 tablespoons chopped parsley",
                     "1 tablespoon dried oregano",
                     "Salt and pepper",
                     "1 cup frozen peas, thawed"
                 ],
                 "ingredients": [
                     {
                         "text": "1/2 cup olive oil",
                         "quantity": 0.5,
                         "measure": "cup",
                         "food": "olive oil",
                         "weight": 108.0,
                         "foodCategory": "Oils",
                         "foodId": "food_b1d1icuad3iktrbqby0hiagafaz7",
                         "image": "https://www.edamam.com/food-img/4d6/4d651eaa8a353647746290c7a9b29d84.jpg"
                     },
                     {
                         "text": "5 cloves garlic, peeled",
                         "quantity": 5.0,
                         "measure": "clove",
                         "food": "garlic",
                         "weight": 15.0,
                         "foodCategory": "vegetables",
                         "foodId": "food_avtcmx6bgjv1jvay6s6stan8dnyp",
                         "image": "https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg"
                     },
                     {
                         "text": "2 large russet potatoes, peeled and cut into chunks",
                         "quantity": 2.0,
                         "measure": "<unit>",
                         "food": "russet potatoes",
                         "weight": 738.0,
                         "foodCategory": "vegetables",
                         "foodId": "food_brsjy86bq09pzgbmr4ri8bnohrf7",
                         "image": "https://www.edamam.com/food-img/71b/71b3756ecfd3d1efa075874377038b67.jpg"
                     },
                     {
                         "text": "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
                         "quantity": 3.5,
                         "measure": "pound",
                         "food": "chicken",
                         "weight": 1587.5732950000001,
                         "foodCategory": "Poultry",
                         "foodId": "food_bmyxrshbfao9s1amjrvhoauob6mo",
                         "image": "https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg"
                     },
                     {
                         "text": "3/4 cup white wine",
                         "quantity": 0.75,
                         "measure": "cup",
                         "food": "white wine",
                         "weight": 176.39999999999998,
                         "foodCategory": "wines",
                         "foodId": "food_bn44h7baron9ufaoxinmya8l0yye",
                         "image": "https://www.edamam.com/food-img/a71/a718cf3c52add522128929f1f324d2ab.jpg"
                     },
                     {
                         "text": "3/4 cup chicken stock",
                         "quantity": 0.75,
                         "measure": "cup",
                         "food": "chicken stock",
                         "weight": 180.0,
                         "foodCategory": "canned soup",
                         "foodId": "food_bptblvzambd16nbhewqmhaw1rnh5",
                         "image": "https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg"
                     },
                     {
                         "text": "3 tablespoons chopped parsley",
                         "quantity": 3.0,
                         "measure": "tablespoon",
                         "food": "parsley",
                         "weight": 11.399999999999999,
                         "foodCategory": "vegetables",
                         "foodId": "food_b244pqdazw24zobr5vqu2bf0uid8",
                         "image": "https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg"
                     },
                     {
                         "text": "1 tablespoon dried oregano",
                         "quantity": 1.0,
                         "measure": "tablespoon",
                         "food": "dried oregano",
                         "weight": 2.9999999997971143,
                         "foodCategory": "Condiments and sauces",
                         "foodId": "food_bkkw6v3bdf0sqiazmzyuiax7i8jr",
                         "image": "https://www.edamam.com/food-img/1b0/1b0eaffb1c261606e0d82fed8e9747a7.jpg"
                     },
                     {
                         "text": "Salt and pepper",
                         "quantity": 0.0,
                         "measure": null,
                         "food": "Salt",
                         "weight": 17.720239769998784,
                         "foodCategory": "Condiments and sauces",
                         "foodId": "food_btxz81db72hwbra2pncvebzzzum9",
                         "image": "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg"
                     },
                     {
                         "text": "Salt and pepper",
                         "quantity": 0.0,
                         "measure": null,
                         "food": "pepper",
                         "weight": 8.860119884999392,
                         "foodCategory": "Condiments and sauces",
                         "foodId": "food_b6ywzluaaxv02wad7s1r9ag4py89",
                         "image": "https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg"
                     },
                     {
                         "text": "1 cup frozen peas, thawed",
                         "quantity": 1.0,
                         "measure": "cup",
                         "food": "frozen peas",
                         "weight": 134.0,
                         "foodCategory": "vegetables",
                         "foodId": "food_aqrct01b4nxw5eaxoo8woaxc3xd7",
                         "image": "https://www.edamam.com/food-img/c91/c9130a361d5c5b279bf48c69e2466ec2.jpg"
                     }
                 ],
                 "calories": 4228.043058200812,
                 "totalWeight": 2976.8664549004047,
                 "totalTime": 60.0,
                 "cuisineType": [
                     "american"
                 ],
                 "mealType": [
                     "lunch/dinner"
                 ],
                 "dishType": [
                     "main course"
                 ],
                 "totalNutrients": {
                     "ENERC_KCAL": {
                         "label": "Energy",
                         "quantity": 4228.043058200812,
                         "unit": "kcal"
                     },
                     "FAT": {
                         "label": "Fat",
                         "quantity": 274.4489059026023,
                         "unit": "g"
                     },
                     "FASAT": {
                         "label": "Saturated",
                         "quantity": 62.497618998656044,
                         "unit": "g"
                     },
                     "FATRN": {
                         "label": "Trans",
                         "quantity": 1.047163345382,
                         "unit": "g"
                     },
                     "FAMS": {
                         "label": "Monounsaturated",
                         "quantity": 147.39060633938868,
                         "unit": "g"
                     },
                     "FAPU": {
                         "label": "Polyunsaturated",
                         "quantity": 47.35051984782951,
                         "unit": "g"
                     },
                     "CHOCDF": {
                         "label": "Carbs",
                         "quantity": 175.96206666631727,
                         "unit": "g"
                     },
                     "FIBTG": {
                         "label": "Fiber",
                         "quantity": 19.83181033081862,
                         "unit": "g"
                     },
                     "SUGAR": {
                         "label": "Sugars",
                         "quantity": 16.239344767255698,
                         "unit": "g"
                     },
                     "PROCNT": {
                         "label": "Protein",
                         "quantity": 230.72689680763318,
                         "unit": "g"
                     },
                     "CHOLE": {
                         "label": "Cholesterol",
                         "quantity": 815.06238045,
                         "unit": "mg"
                     },
                     "NA": {
                         "label": "Sodium",
                         "quantity": 6888.614561646296,
                         "unit": "mg"
                     },
                     "CA": {
                         "label": "Calcium",
                         "quantity": 400.0807431570531,
                         "unit": "mg"
                     },
                     "MG": {
                         "label": "Magnesium",
                         "quantity": 478.1771035229573,
                         "unit": "mg"
                     },
                     "K": {
                         "label": "Potassium",
                         "quantity": 5918.1808352043345,
                         "unit": "mg"
                     },
                     "FE": {
                         "label": "Iron",
                         "quantity": 22.546435238210286,
                         "unit": "mg"
                     },
                     "ZN": {
                         "label": "Zinc",
                         "quantity": 18.341531378501646,
                         "unit": "mg"
                     },
                     "P": {
                         "label": "Phosphorus",
                         "quantity": 2231.0712550999992,
                         "unit": "mg"
                     },
                     "VITA_RAE": {
                         "label": "Vitamin A",
                         "quantity": 635.3716670147774,
                         "unit": "µg"
                     },
                     "VITC": {
                         "label": "Vitamin C",
                         "quantity": 103.72979744959534,
                         "unit": "mg"
                     },
                     "THIA": {
                         "label": "Thiamin (B1)",
                         "quantity": 1.7264528338354403,
                         "unit": "mg"
                     },
                     "RIBF": {
                         "label": "Riboflavin (B2)",
                         "quantity": 1.9119200245119274,
                         "unit": "mg"
                     },
                     "NIA": {
                         "label": "Niacin (B3)",
                         "quantity": 86.90416982948213,
                         "unit": "mg"
                     },
                     "VITB6A": {
                         "label": "Vitamin B6",
                         "quantity": 6.886357390963229,
                         "unit": "mg"
                     },
                     "FOLDFE": {
                         "label": "Folate equivalent (total)",
                         "quantity": 276.2712108159691,
                         "unit": "µg"
                     },
                     "FOLFD": {
                         "label": "Folate (food)",
                         "quantity": 276.2712108159691,
                         "unit": "µg"
                     },
                     "FOLAC": {
                         "label": "Folic acid",
                         "quantity": 0.0,
                         "unit": "µg"
                     },
                     "VITB12": {
                         "label": "Vitamin B12",
                         "quantity": 3.34660450586,
                         "unit": "µg"
                     },
                     "VITD": {
                         "label": "Vitamin D",
                         "quantity": 2.1590996812000003,
                         "unit": "µg"
                     },
                     "TOCPHA": {
                         "label": "Vitamin E",
                         "quantity": 19.62869476856695,
                         "unit": "mg"
                     },
                     "VITK1": {
                         "label": "Vitamin K",
                         "quantity": 353.31486385948267,
                         "unit": "µg"
                     },
                     "WATER": {
                         "label": "Water",
                         "quantity": 1738.7966568296217,
                         "unit": "g"
                     }
                 },
                 "totalDaily": {
                     "ENERC_KCAL": {
                         "label": "Energy",
                         "quantity": 211.4021529100406,
                         "unit": "%"
                     },
                     "FAT": {
                         "label": "Fat",
                         "quantity": 422.2290860040035,
                         "unit": "%"
                     },
                     "FASAT": {
                         "label": "Saturated",
                         "quantity": 312.48809499328024,
                         "unit": "%"
                     },
                     "CHOCDF": {
                         "label": "Carbs",
                         "quantity": 58.65402222210575,
                         "unit": "%"
                     },
                     "FIBTG": {
                         "label": "Fiber",
                         "quantity": 79.32724132327448,
                         "unit": "%"
                     },
                     "PROCNT": {
                         "label": "Protein",
                         "quantity": 461.4537936152663,
                         "unit": "%"
                     },
                     "CHOLE": {
                         "label": "Cholesterol",
                         "quantity": 271.68746015,
                         "unit": "%"
                     },
                     "NA": {
                         "label": "Sodium",
                         "quantity": 287.0256067352624,
                         "unit": "%"
                     },
                     "CA": {
                         "label": "Calcium",
                         "quantity": 40.008074315705315,
                         "unit": "%"
                     },
                     "MG": {
                         "label": "Magnesium",
                         "quantity": 113.85169131498982,
                         "unit": "%"
                     },
                     "K": {
                         "label": "Potassium",
                         "quantity": 125.9187411745603,
                         "unit": "%"
                     },
                     "FE": {
                         "label": "Iron",
                         "quantity": 125.25797354561271,
                         "unit": "%"
                     },
                     "ZN": {
                         "label": "Zinc",
                         "quantity": 166.74119435001495,
                         "unit": "%"
                     },
                     "P": {
                         "label": "Phosphorus",
                         "quantity": 318.7244650142856,
                         "unit": "%"
                     },
                     "VITA_RAE": {
                         "label": "Vitamin A",
                         "quantity": 70.59685189053081,
                         "unit": "%"
                     },
                     "VITC": {
                         "label": "Vitamin C",
                         "quantity": 115.25533049955037,
                         "unit": "%"
                     },
                     "THIA": {
                         "label": "Thiamin (B1)",
                         "quantity": 143.8710694862867,
                         "unit": "%"
                     },
                     "RIBF": {
                         "label": "Riboflavin (B2)",
                         "quantity": 147.0707711163021,
                         "unit": "%"
                     },
                     "NIA": {
                         "label": "Niacin (B3)",
                         "quantity": 543.1510614342633,
                         "unit": "%"
                     },
                     "VITB6A": {
                         "label": "Vitamin B6",
                         "quantity": 529.7197993048637,
                         "unit": "%"
                     },
                     "FOLDFE": {
                         "label": "Folate equivalent (total)",
                         "quantity": 69.06780270399227,
                         "unit": "%"
                     },
                     "VITB12": {
                         "label": "Vitamin B12",
                         "quantity": 139.44185441083332,
                         "unit": "%"
                     },
                     "VITD": {
                         "label": "Vitamin D",
                         "quantity": 14.393997874666669,
                         "unit": "%"
                     },
                     "TOCPHA": {
                         "label": "Vitamin E",
                         "quantity": 130.85796512377968,
                         "unit": "%"
                     },
                     "VITK1": {
                         "label": "Vitamin K",
                         "quantity": 294.42905321623556,
                         "unit": "%"
                     }
                 },
                 "digest": [
                     {
                         "label": "Fat",
                         "tag": "FAT",
                         "schemaOrgTag": "fatContent",
                         "total": 274.4489059026023,
                         "hasRDI": true,
                         "daily": 422.2290860040035,
                         "unit": "g",
                         "sub": [
                             {
                                 "label": "Saturated",
                                 "tag": "FASAT",
                                 "schemaOrgTag": "saturatedFatContent",
                                 "total": 62.497618998656044,
                                 "hasRDI": true,
                                 "daily": 312.48809499328024,
                                 "unit": "g"
                             },
                             {
                                 "label": "Trans",
                                 "tag": "FATRN",
                                 "schemaOrgTag": "transFatContent",
                                 "total": 1.047163345382,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Monounsaturated",
                                 "tag": "FAMS",
                                 "schemaOrgTag": null,
                                 "total": 147.39060633938868,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Polyunsaturated",
                                 "tag": "FAPU",
                                 "schemaOrgTag": null,
                                 "total": 47.35051984782951,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             }
                         ]
                     },
                     {
                         "label": "Carbs",
                         "tag": "CHOCDF",
                         "schemaOrgTag": "carbohydrateContent",
                         "total": 175.96206666631727,
                         "hasRDI": true,
                         "daily": 58.65402222210575,
                         "unit": "g",
                         "sub": [
                             {
                                 "label": "Carbs (net)",
                                 "tag": "CHOCDF.net",
                                 "schemaOrgTag": null,
                                 "total": 0.0,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Fiber",
                                 "tag": "FIBTG",
                                 "schemaOrgTag": "fiberContent",
                                 "total": 19.83181033081862,
                                 "hasRDI": true,
                                 "daily": 79.32724132327448,
                                 "unit": "g"
                             },
                             {
                                 "label": "Sugars",
                                 "tag": "SUGAR",
                                 "schemaOrgTag": "sugarContent",
                                 "total": 16.239344767255698,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Sugars, added",
                                 "tag": "SUGAR.added",
                                 "schemaOrgTag": null,
                                 "total": 0.0,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             }
                         ]
                     },
                     {
                         "label": "Protein",
                         "tag": "PROCNT",
                         "schemaOrgTag": "proteinContent",
                         "total": 230.72689680763318,
                         "hasRDI": true,
                         "daily": 461.4537936152663,
                         "unit": "g"
                     },
                     {
                         "label": "Cholesterol",
                         "tag": "CHOLE",
                         "schemaOrgTag": "cholesterolContent",
                         "total": 815.06238045,
                         "hasRDI": true,
                         "daily": 271.68746015,
                         "unit": "mg"
                     },
                     {
                         "label": "Sodium",
                         "tag": "NA",
                         "schemaOrgTag": "sodiumContent",
                         "total": 6888.614561646296,
                         "hasRDI": true,
                         "daily": 287.0256067352624,
                         "unit": "mg"
                     },
                     {
                         "label": "Calcium",
                         "tag": "CA",
                         "schemaOrgTag": null,
                         "total": 400.0807431570531,
                         "hasRDI": true,
                         "daily": 40.008074315705315,
                         "unit": "mg"
                     },
                     {
                         "label": "Magnesium",
                         "tag": "MG",
                         "schemaOrgTag": null,
                         "total": 478.1771035229573,
                         "hasRDI": true,
                         "daily": 113.85169131498982,
                         "unit": "mg"
                     },
                     {
                         "label": "Potassium",
                         "tag": "K",
                         "schemaOrgTag": null,
                         "total": 5918.1808352043345,
                         "hasRDI": true,
                         "daily": 125.9187411745603,
                         "unit": "mg"
                     },
                     {
                         "label": "Iron",
                         "tag": "FE",
                         "schemaOrgTag": null,
                         "total": 22.546435238210286,
                         "hasRDI": true,
                         "daily": 125.25797354561271,
                         "unit": "mg"
                     },
                     {
                         "label": "Zinc",
                         "tag": "ZN",
                         "schemaOrgTag": null,
                         "total": 18.341531378501646,
                         "hasRDI": true,
                         "daily": 166.74119435001495,
                         "unit": "mg"
                     },
                     {
                         "label": "Phosphorus",
                         "tag": "P",
                         "schemaOrgTag": null,
                         "total": 2231.0712550999992,
                         "hasRDI": true,
                         "daily": 318.7244650142856,
                         "unit": "mg"
                     },
                     {
                         "label": "Vitamin A",
                         "tag": "VITA_RAE",
                         "schemaOrgTag": null,
                         "total": 635.3716670147774,
                         "hasRDI": true,
                         "daily": 70.59685189053081,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin C",
                         "tag": "VITC",
                         "schemaOrgTag": null,
                         "total": 103.72979744959534,
                         "hasRDI": true,
                         "daily": 115.25533049955037,
                         "unit": "mg"
                     },
                     {
                         "label": "Thiamin (B1)",
                         "tag": "THIA",
                         "schemaOrgTag": null,
                         "total": 1.7264528338354403,
                         "hasRDI": true,
                         "daily": 143.8710694862867,
                         "unit": "mg"
                     },
                     {
                         "label": "Riboflavin (B2)",
                         "tag": "RIBF",
                         "schemaOrgTag": null,
                         "total": 1.9119200245119274,
                         "hasRDI": true,
                         "daily": 147.0707711163021,
                         "unit": "mg"
                     },
                     {
                         "label": "Niacin (B3)",
                         "tag": "NIA",
                         "schemaOrgTag": null,
                         "total": 86.90416982948213,
                         "hasRDI": true,
                         "daily": 543.1510614342633,
                         "unit": "mg"
                     },
                     {
                         "label": "Vitamin B6",
                         "tag": "VITB6A",
                         "schemaOrgTag": null,
                         "total": 6.886357390963229,
                         "hasRDI": true,
                         "daily": 529.7197993048637,
                         "unit": "mg"
                     },
                     {
                         "label": "Folate equivalent (total)",
                         "tag": "FOLDFE",
                         "schemaOrgTag": null,
                         "total": 276.2712108159691,
                         "hasRDI": true,
                         "daily": 69.06780270399227,
                         "unit": "µg"
                     },
                     {
                         "label": "Folate (food)",
                         "tag": "FOLFD",
                         "schemaOrgTag": null,
                         "total": 276.2712108159691,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "µg"
                     },
                     {
                         "label": "Folic acid",
                         "tag": "FOLAC",
                         "schemaOrgTag": null,
                         "total": 0.0,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin B12",
                         "tag": "VITB12",
                         "schemaOrgTag": null,
                         "total": 3.34660450586,
                         "hasRDI": true,
                         "daily": 139.44185441083332,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin D",
                         "tag": "VITD",
                         "schemaOrgTag": null,
                         "total": 2.1590996812000003,
                         "hasRDI": true,
                         "daily": 14.393997874666669,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin E",
                         "tag": "TOCPHA",
                         "schemaOrgTag": null,
                         "total": 19.62869476856695,
                         "hasRDI": true,
                         "daily": 130.85796512377968,
                         "unit": "mg"
                     },
                     {
                         "label": "Vitamin K",
                         "tag": "VITK1",
                         "schemaOrgTag": null,
                         "total": 353.31486385948267,
                         "hasRDI": true,
                         "daily": 294.42905321623556,
                         "unit": "µg"
                     },
                     {
                         "label": "Sugar alcohols",
                         "tag": "Sugar.alcohol",
                         "schemaOrgTag": null,
                         "total": 0.0,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "g"
                     },
                     {
                         "label": "Water",
                         "tag": "WATER",
                         "schemaOrgTag": null,
                         "total": 1738.7966568296217,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "g"
                     }
                 ]
             },
             "_links": {
                 "self": {
                     "href": "https://api.edamam.com/api/recipes/v2/b79327d05b8e5b838ad6cfd9576b30b6?type=public&app_id=06863309&app_key=2b6469119d2a85f1ca18276aae53b131",
                     "title": "Self"
                 }
             }
         },
         {
             "recipe": {
                 "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_8275bb28647abcedef0baaf2dcf34f8b",
                 "label": "Chicken Paprikash",
                 "image": "https://www.edamam.com/web-img/e12/e12b8c5581226d7639168f41d126f2ff.jpg",
                 "source": "No Recipes",
                 "url": "http://norecipes.com/recipe/chicken-paprikash/",
                 "shareAs": "http://www.edamam.com/recipe/chicken-paprikash-8275bb28647abcedef0baaf2dcf34f8b/chicken",
                 "yield": 4.0,
                 "dietLabels": [
                     "Low-Carb"
                 ],
                 "healthLabels": [
                     "Egg-Free",
                     "Peanut-Free",
                     "Tree-Nut-Free",
                     "Soy-Free",
                     "Fish-Free",
                     "Shellfish-Free",
                     "Pork-Free",
                     "Red-Meat-Free",
                     "Crustacean-Free",
                     "Celery-Free",
                     "Mustard-Free",
                     "Sesame-Free",
                     "Lupine-Free",
                     "Mollusk-Free",
                     "Alcohol-Free",
                     "Sulfite-Free"
                 ],
                 "cautions": [
                     "Sulfites",
                     "FODMAP"
                 ],
                 "ingredientLines": [
                     "640 grams chicken - drumsticks and thighs ( 3 whole chicken legs cut apart)",
                     "1/2 teaspoon salt",
 
 
 
 
 
 
 
 
 
 
 
 
 {
     "from": 1,
     "to": 20,
     "count": 10000,
     "_links": {
         "next": {
             "href": "https://api.edamam.com/api/recipes/v2?q=chicken&app_key=2b6469119d2a85f1ca18276aae53b131&_cont=CHcVQBtNNQphDmgVQntAEX4BYldtBAAGRmxGC2ERYVJ2BwoVX3cVBWQSY1EhBQcGEmNHVmMTYFEgDQQCFTNJBGQUMQZxVhFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=06863309",
             "title": "Next page"
         }
     },
     "hits": [
         {
             "recipe": {
                 "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6",
                 "label": "Chicken Vesuvio",
                 "image": "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                 "source": "Serious Eats",
                 "url": "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                 "shareAs": "http://www.edamam.com/recipe/chicken-vesuvio-b79327d05b8e5b838ad6cfd9576b30b6/chicken",
                 "yield": 4.0,
                 "dietLabels": [
                     "Low-Carb"
                 ],
                 "healthLabels": [
                     "Mediterranean",
                     "Dairy-Free",
                     "Gluten-Free",
                     "Wheat-Free",
                     "Egg-Free",
                     "Peanut-Free",
                     "Tree-Nut-Free",
                     "Soy-Free",
                     "Fish-Free",
                     "Shellfish-Free",
                     "Pork-Free",
                     "Red-Meat-Free",
                     "Crustacean-Free",
                     "Celery-Free",
                     "Mustard-Free",
                     "Sesame-Free",
                     "Lupine-Free",
                     "Mollusk-Free",
                     "Kosher"
                 ],
                 "cautions": [
                     "Sulfites"
                 ],
                 "ingredientLines": [
                     "1/2 cup olive oil",
                     "5 cloves garlic, peeled",
                     "2 large russet potatoes, peeled and cut into chunks",
                     "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
                     "3/4 cup white wine",
                     "3/4 cup chicken stock",
                     "3 tablespoons chopped parsley",
                     "1 tablespoon dried oregano",
                     "Salt and pepper",
                     "1 cup frozen peas, thawed"
                 ],
                 "ingredients": [
                     {
                         "text": "1/2 cup olive oil",
                         "quantity": 0.5,
                         "measure": "cup",
                         "food": "olive oil",
                         "weight": 108.0,
                         "foodCategory": "Oils",
                         "foodId": "food_b1d1icuad3iktrbqby0hiagafaz7",
                         "image": "https://www.edamam.com/food-img/4d6/4d651eaa8a353647746290c7a9b29d84.jpg"
                     },
                     {
                         "text": "5 cloves garlic, peeled",
                         "quantity": 5.0,
                         "measure": "clove",
                         "food": "garlic",
                         "weight": 15.0,
                         "foodCategory": "vegetables",
                         "foodId": "food_avtcmx6bgjv1jvay6s6stan8dnyp",
                         "image": "https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg"
                     },
                     {
                         "text": "2 large russet potatoes, peeled and cut into chunks",
                         "quantity": 2.0,
                         "measure": "<unit>",
                         "food": "russet potatoes",
                         "weight": 738.0,
                         "foodCategory": "vegetables",
                         "foodId": "food_brsjy86bq09pzgbmr4ri8bnohrf7",
                         "image": "https://www.edamam.com/food-img/71b/71b3756ecfd3d1efa075874377038b67.jpg"
                     },
                     {
                         "text": "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
                         "quantity": 3.5,
                         "measure": "pound",
                         "food": "chicken",
                         "weight": 1587.5732950000001,
                         "foodCategory": "Poultry",
                         "foodId": "food_bmyxrshbfao9s1amjrvhoauob6mo",
                         "image": "https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg"
                     },
                     {
                         "text": "3/4 cup white wine",
                         "quantity": 0.75,
                         "measure": "cup",
                         "food": "white wine",
                         "weight": 176.39999999999998,
                         "foodCategory": "wines",
                         "foodId": "food_bn44h7baron9ufaoxinmya8l0yye",
                         "image": "https://www.edamam.com/food-img/a71/a718cf3c52add522128929f1f324d2ab.jpg"
                     },
                     {
                         "text": "3/4 cup chicken stock",
                         "quantity": 0.75,
                         "measure": "cup",
                         "food": "chicken stock",
                         "weight": 180.0,
                         "foodCategory": "canned soup",
                         "foodId": "food_bptblvzambd16nbhewqmhaw1rnh5",
                         "image": "https://www.edamam.com/food-img/26a/26a10c4cb4e07bab54d8a687ef5ac7d8.jpg"
                     },
                     {
                         "text": "3 tablespoons chopped parsley",
                         "quantity": 3.0,
                         "measure": "tablespoon",
                         "food": "parsley",
                         "weight": 11.399999999999999,
                         "foodCategory": "vegetables",
                         "foodId": "food_b244pqdazw24zobr5vqu2bf0uid8",
                         "image": "https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg"
                     },
                     {
                         "text": "1 tablespoon dried oregano",
                         "quantity": 1.0,
                         "measure": "tablespoon",
                         "food": "dried oregano",
                         "weight": 2.9999999997971143,
                         "foodCategory": "Condiments and sauces",
                         "foodId": "food_bkkw6v3bdf0sqiazmzyuiax7i8jr",
                         "image": "https://www.edamam.com/food-img/1b0/1b0eaffb1c261606e0d82fed8e9747a7.jpg"
                     },
                     {
                         "text": "Salt and pepper",
                         "quantity": 0.0,
                         "measure": null,
                         "food": "Salt",
                         "weight": 17.720239769998784,
                         "foodCategory": "Condiments and sauces",
                         "foodId": "food_btxz81db72hwbra2pncvebzzzum9",
                         "image": "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg"
                     },
                     {
                         "text": "Salt and pepper",
                         "quantity": 0.0,
                         "measure": null,
                         "food": "pepper",
                         "weight": 8.860119884999392,
                         "foodCategory": "Condiments and sauces",
                         "foodId": "food_b6ywzluaaxv02wad7s1r9ag4py89",
                         "image": "https://www.edamam.com/food-img/c6e/c6e5c3bd8d3bc15175d9766971a4d1b2.jpg"
                     },
                     {
                         "text": "1 cup frozen peas, thawed",
                         "quantity": 1.0,
                         "measure": "cup",
                         "food": "frozen peas",
                         "weight": 134.0,
                         "foodCategory": "vegetables",
                         "foodId": "food_aqrct01b4nxw5eaxoo8woaxc3xd7",
                         "image": "https://www.edamam.com/food-img/c91/c9130a361d5c5b279bf48c69e2466ec2.jpg"
                     }
                 ],
                 "calories": 4228.043058200812,
                 "totalWeight": 2976.8664549004047,
                 "totalTime": 60.0,
                 "cuisineType": [
                     "american"
                 ],
                 "mealType": [
                     "lunch/dinner"
                 ],
                 "dishType": [
                     "main course"
                 ],
                 "totalNutrients": {
                     "ENERC_KCAL": {
                         "label": "Energy",
                         "quantity": 4228.043058200812,
                         "unit": "kcal"
                     },
                     "FAT": {
                         "label": "Fat",
                         "quantity": 274.4489059026023,
                         "unit": "g"
                     },
                     "FASAT": {
                         "label": "Saturated",
                         "quantity": 62.497618998656044,
                         "unit": "g"
                     },
                     "FATRN": {
                         "label": "Trans",
                         "quantity": 1.047163345382,
                         "unit": "g"
                     },
                     "FAMS": {
                         "label": "Monounsaturated",
                         "quantity": 147.39060633938868,
                         "unit": "g"
                     },
                     "FAPU": {
                         "label": "Polyunsaturated",
                         "quantity": 47.35051984782951,
                         "unit": "g"
                     },
                     "CHOCDF": {
                         "label": "Carbs",
                         "quantity": 175.96206666631727,
                         "unit": "g"
                     },
                     "FIBTG": {
                         "label": "Fiber",
                         "quantity": 19.83181033081862,
                         "unit": "g"
                     },
                     "SUGAR": {
                         "label": "Sugars",
                         "quantity": 16.239344767255698,
                         "unit": "g"
                     },
                     "PROCNT": {
                         "label": "Protein",
                         "quantity": 230.72689680763318,
                         "unit": "g"
                     },
                     "CHOLE": {
                         "label": "Cholesterol",
                         "quantity": 815.06238045,
                         "unit": "mg"
                     },
                     "NA": {
                         "label": "Sodium",
                         "quantity": 6888.614561646296,
                         "unit": "mg"
                     },
                     "CA": {
                         "label": "Calcium",
                         "quantity": 400.0807431570531,
                         "unit": "mg"
                     },
                     "MG": {
                         "label": "Magnesium",
                         "quantity": 478.1771035229573,
                         "unit": "mg"
                     },
                     "K": {
                         "label": "Potassium",
                         "quantity": 5918.1808352043345,
                         "unit": "mg"
                     },
                     "FE": {
                         "label": "Iron",
                         "quantity": 22.546435238210286,
                         "unit": "mg"
                     },
                     "ZN": {
                         "label": "Zinc",
                         "quantity": 18.341531378501646,
                         "unit": "mg"
                     },
                     "P": {
                         "label": "Phosphorus",
                         "quantity": 2231.0712550999992,
                         "unit": "mg"
                     },
                     "VITA_RAE": {
                         "label": "Vitamin A",
                         "quantity": 635.3716670147774,
                         "unit": "µg"
                     },
                     "VITC": {
                         "label": "Vitamin C",
                         "quantity": 103.72979744959534,
                         "unit": "mg"
                     },
                     "THIA": {
                         "label": "Thiamin (B1)",
                         "quantity": 1.7264528338354403,
                         "unit": "mg"
                     },
                     "RIBF": {
                         "label": "Riboflavin (B2)",
                         "quantity": 1.9119200245119274,
                         "unit": "mg"
                     },
                     "NIA": {
                         "label": "Niacin (B3)",
                         "quantity": 86.90416982948213,
                         "unit": "mg"
                     },
                     "VITB6A": {
                         "label": "Vitamin B6",
                         "quantity": 6.886357390963229,
                         "unit": "mg"
                     },
                     "FOLDFE": {
                         "label": "Folate equivalent (total)",
                         "quantity": 276.2712108159691,
                         "unit": "µg"
                     },
                     "FOLFD": {
                         "label": "Folate (food)",
                         "quantity": 276.2712108159691,
                         "unit": "µg"
                     },
                     "FOLAC": {
                         "label": "Folic acid",
                         "quantity": 0.0,
                         "unit": "µg"
                     },
                     "VITB12": {
                         "label": "Vitamin B12",
                         "quantity": 3.34660450586,
                         "unit": "µg"
                     },
                     "VITD": {
                         "label": "Vitamin D",
                         "quantity": 2.1590996812000003,
                         "unit": "µg"
                     },
                     "TOCPHA": {
                         "label": "Vitamin E",
                         "quantity": 19.62869476856695,
                         "unit": "mg"
                     },
                     "VITK1": {
                         "label": "Vitamin K",
                         "quantity": 353.31486385948267,
                         "unit": "µg"
                     },
                     "WATER": {
                         "label": "Water",
                         "quantity": 1738.7966568296217,
                         "unit": "g"
                     }
                 },
                 "totalDaily": {
                     "ENERC_KCAL": {
                         "label": "Energy",
                         "quantity": 211.4021529100406,
                         "unit": "%"
                     },
                     "FAT": {
                         "label": "Fat",
                         "quantity": 422.2290860040035,
                         "unit": "%"
                     },
                     "FASAT": {
                         "label": "Saturated",
                         "quantity": 312.48809499328024,
                         "unit": "%"
                     },
                     "CHOCDF": {
                         "label": "Carbs",
                         "quantity": 58.65402222210575,
                         "unit": "%"
                     },
                     "FIBTG": {
                         "label": "Fiber",
                         "quantity": 79.32724132327448,
                         "unit": "%"
                     },
                     "PROCNT": {
                         "label": "Protein",
                         "quantity": 461.4537936152663,
                         "unit": "%"
                     },
                     "CHOLE": {
                         "label": "Cholesterol",
                         "quantity": 271.68746015,
                         "unit": "%"
                     },
                     "NA": {
                         "label": "Sodium",
                         "quantity": 287.0256067352624,
                         "unit": "%"
                     },
                     "CA": {
                         "label": "Calcium",
                         "quantity": 40.008074315705315,
                         "unit": "%"
                     },
                     "MG": {
                         "label": "Magnesium",
                         "quantity": 113.85169131498982,
                         "unit": "%"
                     },
                     "K": {
                         "label": "Potassium",
                         "quantity": 125.9187411745603,
                         "unit": "%"
                     },
                     "FE": {
                         "label": "Iron",
                         "quantity": 125.25797354561271,
                         "unit": "%"
                     },
                     "ZN": {
                         "label": "Zinc",
                         "quantity": 166.74119435001495,
                         "unit": "%"
                     },
                     "P": {
                         "label": "Phosphorus",
                         "quantity": 318.7244650142856,
                         "unit": "%"
                     },
                     "VITA_RAE": {
                         "label": "Vitamin A",
                         "quantity": 70.59685189053081,
                         "unit": "%"
                     },
                     "VITC": {
                         "label": "Vitamin C",
                         "quantity": 115.25533049955037,
                         "unit": "%"
                     },
                     "THIA": {
                         "label": "Thiamin (B1)",
                         "quantity": 143.8710694862867,
                         "unit": "%"
                     },
                     "RIBF": {
                         "label": "Riboflavin (B2)",
                         "quantity": 147.0707711163021,
                         "unit": "%"
                     },
                     "NIA": {
                         "label": "Niacin (B3)",
                         "quantity": 543.1510614342633,
                         "unit": "%"
                     },
                     "VITB6A": {
                         "label": "Vitamin B6",
                         "quantity": 529.7197993048637,
                         "unit": "%"
                     },
                     "FOLDFE": {
                         "label": "Folate equivalent (total)",
                         "quantity": 69.06780270399227,
                         "unit": "%"
                     },
                     "VITB12": {
                         "label": "Vitamin B12",
                         "quantity": 139.44185441083332,
                         "unit": "%"
                     },
                     "VITD": {
                         "label": "Vitamin D",
                         "quantity": 14.393997874666669,
                         "unit": "%"
                     },
                     "TOCPHA": {
                         "label": "Vitamin E",
                         "quantity": 130.85796512377968,
                         "unit": "%"
                     },
                     "VITK1": {
                         "label": "Vitamin K",
                         "quantity": 294.42905321623556,
                         "unit": "%"
                     }
                 },
                 "digest": [
                     {
                         "label": "Fat",
                         "tag": "FAT",
                         "schemaOrgTag": "fatContent",
                         "total": 274.4489059026023,
                         "hasRDI": true,
                         "daily": 422.2290860040035,
                         "unit": "g",
                         "sub": [
                             {
                                 "label": "Saturated",
                                 "tag": "FASAT",
                                 "schemaOrgTag": "saturatedFatContent",
                                 "total": 62.497618998656044,
                                 "hasRDI": true,
                                 "daily": 312.48809499328024,
                                 "unit": "g"
                             },
                             {
                                 "label": "Trans",
                                 "tag": "FATRN",
                                 "schemaOrgTag": "transFatContent",
                                 "total": 1.047163345382,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Monounsaturated",
                                 "tag": "FAMS",
                                 "schemaOrgTag": null,
                                 "total": 147.39060633938868,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Polyunsaturated",
                                 "tag": "FAPU",
                                 "schemaOrgTag": null,
                                 "total": 47.35051984782951,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             }
                         ]
                     },
                     {
                         "label": "Carbs",
                         "tag": "CHOCDF",
                         "schemaOrgTag": "carbohydrateContent",
                         "total": 175.96206666631727,
                         "hasRDI": true,
                         "daily": 58.65402222210575,
                         "unit": "g",
                         "sub": [
                             {
                                 "label": "Carbs (net)",
                                 "tag": "CHOCDF.net",
                                 "schemaOrgTag": null,
                                 "total": 0.0,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Fiber",
                                 "tag": "FIBTG",
                                 "schemaOrgTag": "fiberContent",
                                 "total": 19.83181033081862,
                                 "hasRDI": true,
                                 "daily": 79.32724132327448,
                                 "unit": "g"
                             },
                             {
                                 "label": "Sugars",
                                 "tag": "SUGAR",
                                 "schemaOrgTag": "sugarContent",
                                 "total": 16.239344767255698,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             },
                             {
                                 "label": "Sugars, added",
                                 "tag": "SUGAR.added",
                                 "schemaOrgTag": null,
                                 "total": 0.0,
                                 "hasRDI": false,
                                 "daily": 0.0,
                                 "unit": "g"
                             }
                         ]
                     },
                     {
                         "label": "Protein",
                         "tag": "PROCNT",
                         "schemaOrgTag": "proteinContent",
                         "total": 230.72689680763318,
                         "hasRDI": true,
                         "daily": 461.4537936152663,
                         "unit": "g"
                     },
                     {
                         "label": "Cholesterol",
                         "tag": "CHOLE",
                         "schemaOrgTag": "cholesterolContent",
                         "total": 815.06238045,
                         "hasRDI": true,
                         "daily": 271.68746015,
                         "unit": "mg"
                     },
                     {
                         "label": "Sodium",
                         "tag": "NA",
                         "schemaOrgTag": "sodiumContent",
                         "total": 6888.614561646296,
                         "hasRDI": true,
                         "daily": 287.0256067352624,
                         "unit": "mg"
                     },
                     {
                         "label": "Calcium",
                         "tag": "CA",
                         "schemaOrgTag": null,
                         "total": 400.0807431570531,
                         "hasRDI": true,
                         "daily": 40.008074315705315,
                         "unit": "mg"
                     },
                     {
                         "label": "Magnesium",
                         "tag": "MG",
                         "schemaOrgTag": null,
                         "total": 478.1771035229573,
                         "hasRDI": true,
                         "daily": 113.85169131498982,
                         "unit": "mg"
                     },
                     {
                         "label": "Potassium",
                         "tag": "K",
                         "schemaOrgTag": null,
                         "total": 5918.1808352043345,
                         "hasRDI": true,
                         "daily": 125.9187411745603,
                         "unit": "mg"
                     },
                     {
                         "label": "Iron",
                         "tag": "FE",
                         "schemaOrgTag": null,
                         "total": 22.546435238210286,
                         "hasRDI": true,
                         "daily": 125.25797354561271,
                         "unit": "mg"
                     },
                     {
                         "label": "Zinc",
                         "tag": "ZN",
                         "schemaOrgTag": null,
                         "total": 18.341531378501646,
                         "hasRDI": true,
                         "daily": 166.74119435001495,
                         "unit": "mg"
                     },
                     {
                         "label": "Phosphorus",
                         "tag": "P",
                         "schemaOrgTag": null,
                         "total": 2231.0712550999992,
                         "hasRDI": true,
                         "daily": 318.7244650142856,
                         "unit": "mg"
                     },
                     {
                         "label": "Vitamin A",
                         "tag": "VITA_RAE",
                         "schemaOrgTag": null,
                         "total": 635.3716670147774,
                         "hasRDI": true,
                         "daily": 70.59685189053081,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin C",
                         "tag": "VITC",
                         "schemaOrgTag": null,
                         "total": 103.72979744959534,
                         "hasRDI": true,
                         "daily": 115.25533049955037,
                         "unit": "mg"
                     },
                     {
                         "label": "Thiamin (B1)",
                         "tag": "THIA",
                         "schemaOrgTag": null,
                         "total": 1.7264528338354403,
                         "hasRDI": true,
                         "daily": 143.8710694862867,
                         "unit": "mg"
                     },
                     {
                         "label": "Riboflavin (B2)",
                         "tag": "RIBF",
                         "schemaOrgTag": null,
                         "total": 1.9119200245119274,
                         "hasRDI": true,
                         "daily": 147.0707711163021,
                         "unit": "mg"
                     },
                     {
                         "label": "Niacin (B3)",
                         "tag": "NIA",
                         "schemaOrgTag": null,
                         "total": 86.90416982948213,
                         "hasRDI": true,
                         "daily": 543.1510614342633,
                         "unit": "mg"
                     },
                     {
                         "label": "Vitamin B6",
                         "tag": "VITB6A",
                         "schemaOrgTag": null,
                         "total": 6.886357390963229,
                         "hasRDI": true,
                         "daily": 529.7197993048637,
                         "unit": "mg"
                     },
                     {
                         "label": "Folate equivalent (total)",
                         "tag": "FOLDFE",
                         "schemaOrgTag": null,
                         "total": 276.2712108159691,
                         "hasRDI": true,
                         "daily": 69.06780270399227,
                         "unit": "µg"
                     },
                     {
                         "label": "Folate (food)",
                         "tag": "FOLFD",
                         "schemaOrgTag": null,
                         "total": 276.2712108159691,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "µg"
                     },
                     {
                         "label": "Folic acid",
                         "tag": "FOLAC",
                         "schemaOrgTag": null,
                         "total": 0.0,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin B12",
                         "tag": "VITB12",
                         "schemaOrgTag": null,
                         "total": 3.34660450586,
                         "hasRDI": true,
                         "daily": 139.44185441083332,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin D",
                         "tag": "VITD",
                         "schemaOrgTag": null,
                         "total": 2.1590996812000003,
                         "hasRDI": true,
                         "daily": 14.393997874666669,
                         "unit": "µg"
                     },
                     {
                         "label": "Vitamin E",
                         "tag": "TOCPHA",
                         "schemaOrgTag": null,
                         "total": 19.62869476856695,
                         "hasRDI": true,
                         "daily": 130.85796512377968,
                         "unit": "mg"
                     },
                     {
                         "label": "Vitamin K",
                         "tag": "VITK1",
                         "schemaOrgTag": null,
                         "total": 353.31486385948267,
                         "hasRDI": true,
                         "daily": 294.42905321623556,
                         "unit": "µg"
                     },
                     {
                         "label": "Sugar alcohols",
                         "tag": "Sugar.alcohol",
                         "schemaOrgTag": null,
                         "total": 0.0,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "g"
                     },
                     {
                         "label": "Water",
                         "tag": "WATER",
                         "schemaOrgTag": null,
                         "total": 1738.7966568296217,
                         "hasRDI": false,
                         "daily": 0.0,
                         "unit": "g"
                     }
                 ]
             },
             "_links": {
                 "self": {
                     "href": "https://api.edamam.com/api/recipes/v2/b79327d05b8e5b838ad6cfd9576b30b6?type=public&app_id=06863309&app_key=2b6469119d2a85f1ca18276aae53b131",
                     "title": "Self"
                 }
             }
         },
         {
             "recipe": {
                 "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_8275bb28647abcedef0baaf2dcf34f8b",
                 "label": "Chicken Paprikash",
                 "image": "https://www.edamam.com/web-img/e12/e12b8c5581226d7639168f41d126f2ff.jpg",
                 "source": "No Recipes",
                 "url": "http://norecipes.com/recipe/chicken-paprikash/",
                 "shareAs": "http://www.edamam.com/recipe/chicken-paprikash-8275bb28647abcedef0baaf2dcf34f8b/chicken",
                 "yield": 4.0,
                 "dietLabels": [
                     "Low-Carb"
                 ],
                 "healthLabels": [
                     "Egg-Free",
                     "Peanut-Free",
                     "Tree-Nut-Free",
                     "Soy-Free",
                     "Fish-Free",
                     "Shellfish-Free",
                     "Pork-Free",
                     "Red-Meat-Free",
                     "Crustacean-Free",
                     "Celery-Free",
                     "Mustard-Free",
                     "Sesame-Free",
                     "Lupine-Free",
                     "Mollusk-Free",
                     "Alcohol-Free",
                     "Sulfite-Free"
                 ],
                 "cautions": [
                     "Sulfites",
                     "FODMAP"
                 ],
                 "ingredientLines": [
                     "640 grams chicken - drumsticks and thighs ( 3 whole chicken legs cut apart)",
                     "1/2 teaspoon salt",
                     "1/4 teaspoon black pepper",
                     "1 tablespoon butter – cultured unsalted (or olive oil)",
                     "240 grams onion sliced thin (1 large onion)",
                     "70 grams Anaheim pepper chopped (1 large pepper)",
                     "25 grams paprika (about 1/4 cup)",
                     "1 cup chicken stock",
                     "1/2 teaspoon salt",
                     "1/2 cup sour cream",
                     "1 tablespoon flour – all-purpose"
                 ],
                 "ingredients": [
                     {
                         "text": "640 grams chicken - drumsticks and thighs ( 3 whole chicken legs cut apart)",
                         "quantity": 640.0,
                         "measure": "gram",
                         "food": "chicken - drumsticks",
                         "weight": 640.0,
                         "foodCategory": "Poultry",
                         "foodId": "food_agzvc6lbxg03stab195szars32lx",
                         "image": "https://www.edamam.com/food-img/491/4916353c22bd1ac381ac81d55597ddbe.jpg"
                     },
               

 */
