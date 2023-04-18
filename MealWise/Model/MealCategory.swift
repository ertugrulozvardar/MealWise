//
//  MealModel.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 5.04.2023.
//

import Foundation

// MARK: - MealCategoryResponse
struct MealCategoryResponse: Codable {
    let categories: [MealCategory]
}

// MARK: - Category
struct MealCategory: Codable {
    let idCategory, strCategory: String?
    let strCategoryThumb: String?
    let strCategoryDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case idCategory, strCategory
        case strCategoryThumb
        case strCategoryDescription
    }
}

extension MealCategory {
    
    static var dummyData: MealCategory {
        .init(idCategory: StringConstants.dummyDataMealCategoryId, strCategory: StringConstants.dummyDataMealCategoryName, strCategoryThumb: StringConstants.dummyDataMealCategoryImageName, strCategoryDescription: StringConstants.dummyDataMealCategoryDescription)
    }
}
