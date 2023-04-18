//
//  APIError.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 5.04.2023.
//

import Foundation

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return StringConstants.decodingErrorText
        case .errorCode(let code):
            return "\(code)" + StringConstants.somethingWentWrongText
        case .unknown:
            return StringConstants.unknownErrorText
        }
    }
}
