//
//  NetworkCredentials.swift
//  MealWise
//
//  Created by ertugrul.ozvardar on 16.04.2023.
//

import Foundation

enum NetworkCredentials {
    static let apiKeyText = "X-RapidAPI-Key"
    static let apiHostText = "X-RapidAPI-Host"
    static let apiKey = "YOUR-API-KEY-HERE"
    static let apiHost = "themealdb.p.rapidapi.com"
    static let baseURL = "https://themealdb.p.rapidapi.com"
    static let categoriesPath = "/categories.php"
    static let listPath = "/list.php"
    static let filterPath = "/filter.php"
    static let lookupPath = "/lookup.php"
}
