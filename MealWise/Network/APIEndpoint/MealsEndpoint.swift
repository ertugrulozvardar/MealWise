//
//  MealsEndpoint.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 5.04.2023.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
    var httpHeaders: [String: String] { get }
}

enum MealsAPI {
    case getCategories
    case getCuisines
    case getMealsByCategory(category: String)
    case getMealsByCuisine(cuisine: String)
    case getMealById(id: String)
}

extension MealsAPI: APIBuilder {
    
    var httpHeaders: [String: String] {
        let headers = [
            NetworkCredentials.apiKeyText: NetworkCredentials.apiKey,
            NetworkCredentials.apiHostText: NetworkCredentials.apiHost
        ]
        return headers
    }
    
    var baseUrl: URL {
        return URL(string: NetworkCredentials.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return NetworkCredentials.categoriesPath
        case .getCuisines:
            return NetworkCredentials.listPath
        case .getMealsByCategory:
            return NetworkCredentials.filterPath
        case .getMealsByCuisine:
            return NetworkCredentials.filterPath
        case .getMealById:
            return NetworkCredentials.lookupPath
        }
    }
    
    var urlRequest: URLRequest {
        switch self {
        case .getCategories:
            let finalURL = self.baseUrl.appendingPathComponent(self.path)
            var request = URLRequest(url: finalURL)
            request.httpMethod = getHttpMethod(httpMethod: .get)
            request.allHTTPHeaderFields = httpHeaders
            var components = URLComponents(url: finalURL, resolvingAgainstBaseURL: false)!
            request.url = components.url
            return request
        case .getCuisines:
            let finalURL = self.baseUrl.appendingPathComponent(self.path)
            var request = URLRequest(url: finalURL)
            request.httpMethod = getHttpMethod(httpMethod: .get)
            request.allHTTPHeaderFields = httpHeaders
            let params = [getHttpParameter(param: .area): StringConstants.list]
            let queryItems = params.map { URLQueryItem(name: $0.key!, value: $0.value) }
            var components = URLComponents(url: finalURL, resolvingAgainstBaseURL: false)!
            components.queryItems = queryItems
            request.url = components.url
            return request
        case .getMealsByCategory(let category):
            let finalURL = self.baseUrl.appendingPathComponent(self.path)
            var request = URLRequest(url: finalURL)
            request.httpMethod = getHttpMethod(httpMethod: .get)
            request.allHTTPHeaderFields = httpHeaders
            let params = [getHttpParameter(param: .category): category]
            let queryItems = params.map { URLQueryItem(name: $0.key!, value: $0.value) }
            var components = URLComponents(url: finalURL, resolvingAgainstBaseURL: false)!
            components.queryItems = queryItems
            request.url = components.url
            return request
        case .getMealsByCuisine(cuisine: let cuisine):
            let finalURL = self.baseUrl.appendingPathComponent(self.path)
            var request = URLRequest(url: finalURL)
            request.httpMethod = getHttpMethod(httpMethod: .get)
            request.allHTTPHeaderFields = httpHeaders
            let params = [getHttpParameter(param: .area): cuisine]
            let queryItems = params.map { URLQueryItem(name: $0.key!, value: $0.value) }
            var components = URLComponents(url: finalURL, resolvingAgainstBaseURL: false)!
            components.queryItems = queryItems
            request.url = components.url
            return request
        case .getMealById(id: let id):
            let finalURL = self.baseUrl.appendingPathComponent(self.path)
            var request = URLRequest(url: finalURL)
            request.httpMethod = getHttpMethod(httpMethod: .get)
            request.allHTTPHeaderFields = httpHeaders
            let params = [getHttpParameter(param: .id): id]
            let queryItems = params.map { URLQueryItem(name: $0.key!, value: $0.value) }
            var components = URLComponents(url: finalURL, resolvingAgainstBaseURL: false)!
            components.queryItems = queryItems
            request.url = components.url
            return request
        }
    }
}
