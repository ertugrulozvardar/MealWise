//
//  HTTPParameters.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 11.04.2023.
//

import Foundation

enum HTTPParameters {
    case id
    case area
    case category
}

func getHttpParameter(param: HTTPParameters) -> String? {
    switch param {
    case .id:
        return "i"
    case .area:
        return "a"
    case .category:
        return "c"
    default:
        break
    }
}
