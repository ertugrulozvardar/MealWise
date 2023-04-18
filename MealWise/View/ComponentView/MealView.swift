//
//  MealView.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 10.04.2023.
//

import SwiftUI
import URLImage

struct MealView: View {
    
    let meal: Meal
    
    var body: some View {
        HStack() {
            if let image = meal.strMealThumb,
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
                        .frame(width: 120, height: 120)
                        .padding()
                } content: { image in
                    image
                        .resizable()
                        .cornerRadius(15)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .environment(\.urlImageOptions,
                              .init(fetchPolicy: .returnStoreElseLoad(downloadDelay: nil)))
                
            } else {
                Image(systemName: StringConstants.systemImageNameFill)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .frame(width: 120, height: 120)
            }
            if let meal = meal.strMeal {
                Text(meal)
                    .font(
                        .custom(StringConstants.customFontNameAmericanTypeWriter, size: 21)
                        .weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
            }
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView(meal: Meal.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
