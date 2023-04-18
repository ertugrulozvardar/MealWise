//
//  CategoryView.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 6.04.2023.
//

import SwiftUI
import URLImage

struct CategoryView: View {
    
    let category: MealCategory
    @State var isDisplayDetail = false
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.orange, .red]), center: .center, startRadius: 50, endRadius: 200)
                .ignoresSafeArea()
            VStack {
                if let mealCategory = category.strCategory {
                    Text(mealCategory)
                        .font(
                            .custom(StringConstants.customFontNameAmericanTypeWriter, size: 24)
                            .weight(.semibold))
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                        .padding(.top)
                }
                if let image = category.strCategoryThumb,
                   let url = URL(string: image){
                    URLImage(url, identifier: url.absoluteString) {
                        EmptyView()
                    } inProgress: { progress in
                        ProgressView()
                    } failure: { error, retry in
                        Image(systemName: StringConstants.systemImageNameFill)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .frame(width: 120, height: 120)
                            .padding()
                    } content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .padding()
                    }
                    .environment(\.urlImageOptions,
                                  .init(fetchPolicy: .returnStoreElseLoad(downloadDelay: nil)))
                    
                } else {
                    Image(systemName: StringConstants.systemImageNameFill)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .frame(width: 120, height: 120)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        isDisplayDetail = true
                    }, label: {
                        Image(systemName: StringConstants.systemImageNameInfoCircle)
                            .foregroundColor(.mint)
                    })
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if isDisplayDetail {
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isDisplayDetail = false
                        }
                    VStack {
                        if let mealDescription = category.strCategoryDescription {
                            Text(mealDescription)
                                .font(.footnote)
                                .foregroundColor(.orange)
                        }
                        Button(StringConstants.dismiss) {
                            isDisplayDetail = false
                        }
                        .padding()
                    }
                    .frame(width: 200, height: 200)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                }.frame(alignment: .center)
            }
        }
        .cornerRadius(18)
        .shadow(radius: 10)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: MealCategory.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
