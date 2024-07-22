//
//  ViewModel.swift
//  recipeApp
//
//  Created by Jonathan Novecio on 7/15/24.
//

import Foundation
import SwiftUI

final class MealsViewModel: ObservableObject {
    
    @Published var mealList: [Meal] = []
    @Published var mealDetail: Recipe?
    @Published var ingredientsDict: [String: String] = [:]
    
    func fetchMeals() {
        let userUrlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        if let url = URL(string: userUrlString) {
            URLSession
                .shared
                .dataTask(with: url) {[weak self] data, response, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print(error)
                        } else {
                            
                            let decoder = JSONDecoder()
                            if let data = data,
                               let meals = try? decoder.decode(MealsResponse.self, from: data) {
                                
                                self?.mealList = meals.meals
                            } else {
                                
                            }
                        }
                    }
                }.resume()
        }
    }
}

