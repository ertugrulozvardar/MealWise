//
//  Meal.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 10.04.2023.
//

import Foundation

// MARK: - MealResponse
struct MealResponse: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
}

extension Meal {
    
    static var dummyData: Meal {
        .init(strMeal: StringConstants.dummyDataMealName, strMealThumb: StringConstants.dummyDataMealImageName, idMeal: StringConstants.dummyDataMealId)
    }
}
