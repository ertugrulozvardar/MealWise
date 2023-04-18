//
//  MealDetailViewModel.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 11.04.2023.
//

import Foundation
import Combine

protocol MealDetailViewModel {
    func fetchMealDetail(by mealId: String)
}

enum MealDetailResponseState {
    case loading
    case failed(error: Error)
    case success(content: [MealDetail])
}

class MealDetailViewModelImplementation: ObservableObject, MealDetailViewModel {
    
    private let mealDetailService: MealDetailService
    private(set) var mealDetail = [MealDetail]()
    
    @Published private(set) var mealDetailState: MealDetailResponseState = .loading
    private var cancellables = Set<AnyCancellable>()
    
    init(mealDetailService: MealDetailService) {
        self.mealDetailService = mealDetailService
    }
    
    func fetchMealDetail(by mealId: String) {
        self.mealDetailState = .loading
        let cancellable = self.mealDetailService
            .request(from: .getMealById(id: mealId))
            .sink { (res) in
                switch res {
                case .failure(let error):
                    self.mealDetailState = .failed(error: error)
                case .finished:
                    self.mealDetailState = .success(content: self.mealDetail)
                }
            } receiveValue: { res in
                self.mealDetail = res.meals
            }
        self.cancellables.insert(cancellable)
    }
}
