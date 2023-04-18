//
//  MealDetail.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 11.04.2023.
//

import Foundation

// MARK: - MealDetailResponse
struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

// MARK: - Meal
struct MealDetail: Codable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        
    }
    
    var ingredients: [String] {
        var ingredientList: [String] = []
        if let ing1 = strIngredient1, let ing2 = strIngredient2, let ing3 = strIngredient3, let ing4 = strIngredient4, let ing5 = strIngredient5, let ing6 = strIngredient6, let ing7 = strIngredient7, let ing8 = strIngredient8, let ing9 = strIngredient9, let ing10 = strIngredient10, let ing11 = strIngredient11, let ing12 = strIngredient12, let ing13 = strIngredient13, let ing14 = strIngredient14, let ing15 = strIngredient15, let ing16 = strIngredient16, let ing17 = strIngredient17, let ing18 = strIngredient18, let ing19 = strIngredient19, let ing20 = strIngredient20 {
            ingredientList.append(ing1)
            ingredientList.append(ing2)
            ingredientList.append(ing3)
            ingredientList.append(ing4)
            ingredientList.append(ing5)
            ingredientList.append(ing6)
            ingredientList.append(ing7)
            ingredientList.append(ing8)
            ingredientList.append(ing9)
            ingredientList.append(ing10)
            ingredientList.append(ing11)
            ingredientList.append(ing12)
            ingredientList.append(ing13)
            ingredientList.append(ing14)
            ingredientList.append(ing15)
            ingredientList.append(ing16)
            ingredientList.append(ing17)
            ingredientList.append(ing18)
            ingredientList.append(ing19)
            ingredientList.append(ing20)
        }
        return ingredientList
    }
}

extension MealDetail {
    
    static var dummyData: MealDetail {
        .init(idMeal: StringConstants.dummyDataMealDetailPlaceholder, strMeal: StringConstants.dummyDataMealDetailPlaceholder, strDrinkAlternate: StringConstants.dummyDataMealDetailPlaceholder, strCategory: StringConstants.dummyDataMealDetailPlaceholder, strArea: StringConstants.dummyDataMealDetailPlaceholder, strInstructions: StringConstants.dummyDataMealDetailPlaceholder, strMealThumb: StringConstants.dummyDataMealDetailPlaceholder, strTags: StringConstants.dummyDataMealDetailPlaceholder, strYoutube: StringConstants.dummyDataMealDetailPlaceholder, strIngredient1: StringConstants.dummyDataMealDetailPlaceholder, strIngredient2: StringConstants.dummyDataMealDetailPlaceholder, strIngredient3: StringConstants.dummyDataMealDetailPlaceholder, strIngredient4: StringConstants.dummyDataMealDetailPlaceholder, strIngredient5: StringConstants.dummyDataMealDetailPlaceholder, strIngredient6: StringConstants.dummyDataMealDetailPlaceholder, strIngredient7: StringConstants.dummyDataMealDetailPlaceholder, strIngredient8: StringConstants.dummyDataMealDetailPlaceholder, strIngredient9: StringConstants.dummyDataMealDetailPlaceholder, strIngredient10: StringConstants.dummyDataMealDetailPlaceholder, strIngredient11: StringConstants.dummyDataMealDetailPlaceholder, strIngredient12: StringConstants.dummyDataMealDetailPlaceholder, strIngredient13: StringConstants.dummyDataMealDetailPlaceholder, strIngredient14: StringConstants.dummyDataMealDetailPlaceholder, strIngredient15: StringConstants.dummyDataMealDetailPlaceholder, strIngredient16: StringConstants.dummyDataMealDetailPlaceholder, strIngredient17: StringConstants.dummyDataMealDetailPlaceholder, strIngredient18: StringConstants.dummyDataMealDetailPlaceholder, strIngredient19: StringConstants.dummyDataMealDetailPlaceholder, strIngredient20: StringConstants.dummyDataMealDetailPlaceholder)
    }
}
