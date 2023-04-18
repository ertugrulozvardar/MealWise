//
//  ContentView.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 5.04.2023.
//

import SwiftUI
import URLImage

struct HomeView: View {
    
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    
    @StateObject var homeViewModel: HomeViewModelImplementation = HomeViewModelImplementation(categoryService: CategoryServiceImplementation(), cuisineService: CuisineServiceImplementation())
    @State private var selectedCategory: String = ""
    @State private var selectedCuisine: String = ""
    @State private var isCategoryActive = false
    @State private var isCuisineActive = false
    @State var mealCategory: String = ""
    @State var mealCuisine: String = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            TabView() {
                Group {   // MARK: CATEGORY VIEW
                    switch homeViewModel.categoryState {
                    case .loading:
                        ProgressView()
                    case .failed(let error):
                        ErrorView(error: error) {
                            self.homeViewModel.fetchCategories()
                        }
                    case .success(let content):
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(content, id: \.idCategory) { category in
                                    CategoryView(category: category).onTapGesture {
                                        selectedCategory = category.strCategory!
                                        self.isCategoryActive = true
                                    }
                                }
                            }
                            .padding()
                        }.background(
                            NavigationLink(destination: CategoryMealsView(category: selectedCategory), isActive: $isCategoryActive) {
                            }
                        )
                    }
                }
                .tabItem {
                    Image(systemName: StringConstants.systemImageNameBulletRectangle)
                    Text(StringConstants.category)
                }
                
                Group {   // MARK: CUISINE VIEW
                    switch homeViewModel.cuisineState {
                    case .loading:
                        ProgressView()
                    case .failed(let error):
                        ErrorView(error: error) {
                            self.homeViewModel.fetchCuisines()
                        }
                    case .success(let content):
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(content, id: \.cuisineId) { cuisine in
                                    CuisineView(cuisine: cuisine).onTapGesture {
                                        selectedCuisine = cuisine.strArea!
                                        self.isCuisineActive = true
                                    }
                                }
                            }
                            .padding()
                        }.background(
                            NavigationLink(destination: CuisineMealsView(cuisine: selectedCuisine), isActive: $isCuisineActive) {
                            }
                        )
                    }
                }
                .tabItem {
                    Image(systemName: StringConstants.systemImageNameFlag)
                    Text(StringConstants.cuisine)
                }
            }
        }
        .onAppear {
            self.homeViewModel.fetchCategories()
            self.homeViewModel.fetchCuisines()
        }.task {
            try? await Task.sleep(for: Duration.seconds(2.5))
            self.launchScreenState.dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LaunchScreenStateManager())
    }
}
