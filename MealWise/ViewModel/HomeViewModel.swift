//
//  CategoryViewModel.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 5.04.2023.
//

import Foundation
import Combine

protocol HomeViewModel {
    func fetchCategories()
}

enum CategoryResponseState {
    case loading
    case failed(error: Error)
    case success(content: [MealCategory])
}

enum CuisineResponseState {
    case loading
    case failed(error: Error)
    case success(content: [Cuisine])
}

class HomeViewModelImplementation: ObservableObject, HomeViewModel {
    
    private let categoryService: CategoryService
    private(set) var categories = [MealCategory]()
    private let cuisineService: CuisineService
    private(set) var cuisines = [Cuisine]()
    
    @Published private(set) var categoryState: CategoryResponseState = .loading
    @Published private(set) var cuisineState: CuisineResponseState = .loading
    private var cancellables = Set<AnyCancellable>()
    
    init(categoryService: CategoryService, cuisineService: CuisineService) {
        self.categoryService = categoryService
        self.cuisineService = cuisineService
    }
    
    func fetchCategories() {
        self.categoryState = .loading
        let cancellable = self.categoryService
            .request(from: .getCategories)
            .sink { (res) in
                switch res {
                case .failure(let error):
                    self.categoryState = .failed(error: error)
                case .finished:
                    self.categoryState = .success(content: self.categories)
                }
            } receiveValue: { res in
                self.categories = res.categories
            }
        self.cancellables.insert(cancellable)
    }
    
    func fetchCuisines() {
        self.cuisineState = .loading
        let cancellable = self.cuisineService
            .request(from: .getCuisines)
            .sink { (res) in
                switch res {
                case .failure(let error):
                    self.cuisineState = .failed(error: error)
                case .finished:
                    self.cuisineState = .success(content: self.cuisines)
                }
            } receiveValue: { res in
                self.cuisines = res.meals
            }
        self.cancellables.insert(cancellable)
    }
}
