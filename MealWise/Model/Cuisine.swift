//
//  CuisineResponse.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 5.04.2023.
//

import Foundation

// MARK: - CuisineResponse
struct CuisineResponse: Codable {
    let meals: [Cuisine]
}

// MARK: - Meal
struct Cuisine: Codable {
    let strArea: String?
    
    enum CodingKeys: String, CodingKey {
        case strArea
    }
    
    var strImage: String {
        return strArea! + StringConstants.imageFileExtension
    }
    
    var cuisineId: String {
        return UUID().uuidString
    }
}

extension Cuisine {
    
    static var dummyData: Cuisine {
        .init(strArea: StringConstants.turkish)
    }
}
