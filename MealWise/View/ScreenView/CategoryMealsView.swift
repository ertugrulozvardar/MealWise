import SwiftUI
import Combine


struct CategoryMealsView: View {
    
    @StateObject var mealsViewModel: MealsViewModelImplementation = MealsViewModelImplementation(mealService: MealServiceImplementation())
    @State private var selectedMealId: String = ""
    @State private var isActive = false
    @State private var searchQuery = ""
    @State var mealId: String = ""
    var category: String = ""
    
    
    var body: some View {
        
        Group {
            switch mealsViewModel.mealState {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error) {
                    getMeals()
                }
            case .success(_):
                NavigationView {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack {
                            ForEach(filteredMeals, id: \.idMeal) { meal in
                                MealView(meal: meal).onTapGesture {
                                    selectedMealId = meal.idMeal!
                                    self.isActive = true
                                }
                                
                            }
                        }.background(.orange)
                    }.background(.orange)
                        .searchable(text: $searchQuery)
                        .onSubmit(of: .search, getMeals)
                        .environment(\.defaultMinListRowHeight, 150)
                }
                .background(
                    NavigationLink(destination: MealDetailView(mealId: selectedMealId), isActive: $isActive) {
                        EmptyView()
                    }
                )
            }
        }
        .defersSystemGestures(on: .vertical)
        .onAppear {
            getMeals()
        }
    }
    var filteredMeals: [Meal] {
        if searchQuery.isEmpty {
            return mealsViewModel.categoryMeals
        } else {
            return mealsViewModel.categoryMeals.filter { $0.strMeal!.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
    
    func getMeals() {
        Task {
            mealsViewModel.fetchCategoryMeals(by: category)
        }
    }
}

struct CategoryMealsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryMealsView()
    }
}
