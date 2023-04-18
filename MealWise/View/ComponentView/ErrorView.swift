//
//  ErrorView.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 5.04.2023.
//

import SwiftUI

typealias EmptyStateActionHandler = () -> Void

struct ErrorView: View {
    
    private let handler: EmptyStateActionHandler
    private var error: Error
    
    internal init(
        error: Error,
        handler: @escaping EmptyStateActionHandler) {
            self.error = error
            self.handler = handler
        }
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: StringConstants.systemImageNameExclamationIcloudFill)
                .foregroundColor(.gray)
                .font(.system(size: 50, weight: .heavy))
            Text(StringConstants.errorOops)
                .font(.system(size: 30, weight: .heavy))
            Text(error.localizedDescription)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            Button(StringConstants.pleaseRetry) {
                handler()
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 10)
            .font(.system(size: 20, weight: .bold))
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: APIError.decodingError) {
            
        }
    }
}
