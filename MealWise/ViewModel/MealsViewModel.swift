//
//  MealsViewModel.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 10.04.2023.
//

import Foundation
import Combine

protocol MealsViewModel {
    func fetchCategoryMeals(by mealCategory: String)
    func fetchCuisineMeals(by mealCuisine: String)
}

enum MealResponseState {
    case loading
    case failed(error: Error)
    case success(content: [Meal])
}

class MealsViewModelImplementation: ObservableObject, MealsViewModel {
    
    private let mealService: MealService
    private(set) var categoryMeals = [Meal]()
    private(set) var cuisineMeals = [Meal]()
    
    @Published private(set) var mealState: MealResponseState = .loading
    private var cancellables = Set<AnyCancellable>()
    
    init(mealService: MealService) {
        self.mealService = mealService
    }
    
    func fetchCategoryMeals(by mealCategory: String) {
        self.mealState = .loading
        let cancellable = self.mealService
            .request(from: .getMealsByCategory(category: mealCategory))
            .sink { (res) in
                switch res {
                case .failure(let error):
                    self.mealState = .failed(error: error)
                case .finished:
                    self.mealState = .success(content: self.categoryMeals)
                }
            } receiveValue: { res in
                self.categoryMeals = res.meals
            }
        self.cancellables.insert(cancellable)
    }
    
    func fetchCuisineMeals(by mealCuisine: String) {
        self.mealState = .loading
        let cancellable = self.mealService
            .request(from: .getMealsByCuisine(cuisine: mealCuisine))
            .sink { (res) in
                switch res {
                case .failure(let error):
                    self.mealState = .failed(error: error)
                case .finished:
                    self.mealState = .success(content: self.cuisineMeals)
                }
            } receiveValue: { res in
                self.cuisineMeals = res.meals
            }
        self.cancellables.insert(cancellable)
    }
}
