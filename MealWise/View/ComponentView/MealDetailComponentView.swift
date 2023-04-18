//
//  MealDetailView.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 11.04.2023.
//

import SwiftUI
import SwiftyTranslate
import URLImage

struct MealDetailComponentView: View {
    
    @Environment(\.openURL) var openURL
    @State private var isTranslated = false
    @State private var isTranslatePressed = false
    @State var currentRecipe: String = ""
    @State var languageImageName: String = LanguageCodes.turkish.rawValue
    let mealDetail: MealDetail
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack() {
            //TRANSLATION BUTTON
            Button {
                if !isTranslated {
                    SwiftyTranslate.translate(text: currentRecipe, from: LanguageCodes.english.rawValue, to: LanguageCodes.turkish.rawValue) { result in
                        switch result {
                        case .success(let translation):
                            currentRecipe = translation.translated
                        case .failure(let error):
                            currentRecipe = "\(error)" + StringConstants.recipeTranslationErrorMessage
                        }
                    }
                    isTranslated = true
                    languageImageName = LanguageCodes.english.rawValue
                } else {
                    SwiftyTranslate.translate(text: currentRecipe, from: LanguageCodes.turkish.rawValue, to: LanguageCodes.english.rawValue) { result in
                        switch result {
                        case .success(let translation):
                            currentRecipe = translation.translated
                        case .failure(let error):
                            currentRecipe = "\(error)" + StringConstants.recipeTranslationErrorMessage
                        }
                    }
                    isTranslated = false
                    languageImageName = LanguageCodes.turkish.rawValue
                }
            } label: {
                Image(languageImageName)
            }
            .frame(width: 25, height: 25)
            .buttonStyle(.borderless)
            .scaleEffect(isTranslatePressed ? 1.05 : 1.0)
            .opacity(isTranslatePressed ? 0.6 : 1.0)
            .pressEvents {
                withAnimation(.linear(duration: 2.5)) {
                    isTranslatePressed = true
                }
            } onRelease: {
                withAnimation {
                    isTranslatePressed = false
                }
            }
            
            ZStack(alignment: .top) {
                // MEAL IMAGE
                if let image = mealDetail.strMealThumb,
                   let url = URL(string: image){
                    URLImage(url, identifier: url.absoluteString) {
                        EmptyView()
                    } inProgress: { progress in
                        ProgressView()
                    } failure: { error, retry in
                        Image(systemName: StringConstants.systemImageNameFill)
                            .cornerRadius(15)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .padding()
                    } content: { image in
                        image
                            .resizable()
                            .cornerRadius(15)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                    .environment(\.urlImageOptions,
                                  .init(fetchPolicy: .returnStoreElseLoad(downloadDelay: nil)))
                    
                } else {
                    Image(systemName: StringConstants.systemImageNameFill)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .background(Color.gray)
                }
                
                //MEAL NAME
                if let meal = mealDetail.strMeal {
                    Text(meal)
                        .font(
                            .custom(StringConstants.customFontNameAmericanTypeWriter, size: 28)
                            .weight(.semibold))
                        .padding()
                        .minimumScaleFactor(0.5)
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .multilineTextAlignment(.center)
                }
            }
            // MEAL INGREDIENTS
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(mealDetail.ingredients.indices) { index in
                    let ingredient = mealDetail.ingredients[index]
                    if !ingredient.isEmpty {
                        Text(ingredient)
                            .font(
                                .custom(StringConstants.customFontNameAmericanTypeWriter, size: 16)
                                .weight(.semibold))
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            // MEAL RECIPE
            Text(currentRecipe)
                .font(
                    .custom(StringConstants.customFontNameAmericanTypeWriter, size: 20)
                    .weight(.semibold))
                .padding(.top)
                .fixedSize(horizontal: false, vertical: true)
                .opacity(isTranslatePressed ? 0.4 : 1.0)
                .scaleEffect(isTranslatePressed ? 1.2 : 1.0)
                .onAppear {
                    if let recipe = mealDetail.strInstructions {
                        currentRecipe = recipe
                    }
                }
            
            Button {
                loadExternalLink(with: mealDetail.strYoutube)
            } label: {
                Image(StringConstants.customImageNameYoutube)
            }
            .buttonStyle(.borderless)
        }
        .defersSystemGestures(on: .vertical)
    }
    
    func loadExternalLink(with url: String?) {
        guard let url = url,
              let linkUrl = URL(string: url) else {
            return
        }
        openURL(linkUrl)
    }
}

struct MealDetailComponentView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailComponentView(mealDetail: MealDetail.dummyData)
    }
}
