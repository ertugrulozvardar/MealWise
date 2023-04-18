//
//  MealDetailService.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 10.04.2023.
//

import Foundation
import Combine

protocol MealDetailService {
    func request(from endpoint: MealsAPI) -> AnyPublisher<MealDetailResponse, APIError>
}

struct MealDetailServiceImplementation: MealDetailService {
    
    func request(from endpoint: MealsAPI) -> AnyPublisher<MealDetailResponse, APIError> {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<MealDetailResponse, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: MealDetailResponse.self, decoder: jsonDecoder)
                        .mapError {_ in .decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: .errorCode(response.statusCode))
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}

