//
//  MealService.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 10.04.2023.
//

import Foundation
import Combine

protocol MealService {
    func request(from endpoint: MealsAPI) -> AnyPublisher<MealResponse, APIError>
}

struct MealServiceImplementation: MealService {
    
    func request(from endpoint: MealsAPI) -> AnyPublisher<MealResponse, APIError> {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<MealResponse, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: MealResponse.self, decoder: jsonDecoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode))
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
