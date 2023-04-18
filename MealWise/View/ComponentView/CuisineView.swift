//
//  CuisineView.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 6.04.2023.
//

import SwiftUI

struct CuisineView: View {
    
    let cuisine: Cuisine
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.orange, .red]), center: .center, startRadius: 50, endRadius: 200)
                .ignoresSafeArea()
            VStack {
                if let mealCuisine = cuisine.strArea {
                    Text(mealCuisine)
                        .font(
                            .custom(StringConstants.customFontNameAmericanTypeWriter, size: 24)
                            .weight(.semibold))
                        .foregroundColor(.white)
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                        .padding(.top)
                }
                if let image = cuisine.strArea {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .padding()
                }
                else {
                    Image(systemName: StringConstants.systemImageNameFill)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .frame(width: 120, height: 120)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .cornerRadius(18)
        .shadow(radius: 10)
    }
}

struct CuisineView_Previews: PreviewProvider {
    static var previews: some View {
        CuisineView(cuisine: Cuisine.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
