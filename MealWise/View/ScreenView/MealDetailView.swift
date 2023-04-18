//
//  MealDetailView.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 11.04.2023.
//

import SwiftUI

struct MealDetailView: View {
    
    @StateObject var mealDetailViewModel: MealDetailViewModelImplementation = MealDetailViewModelImplementation(mealDetailService: MealDetailServiceImplementation())
    var mealId: String = ""
    
    var body: some View {
        Group {
            switch mealDetailViewModel.mealDetailState {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error) {
                    self.mealDetailViewModel.fetchMealDetail(by: mealId)
                }
            case .success(let content):
                NavigationView {
                    List(content, id: \.idMeal) { mealDetail in
                        MealDetailComponentView(mealDetail: mealDetail)
                    }
                    .environment(\.defaultMinListRowHeight, 150)
                }
            }
        }
        .onAppear {
            self.mealDetailViewModel.fetchMealDetail(by: mealId)
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView()
    }
}
