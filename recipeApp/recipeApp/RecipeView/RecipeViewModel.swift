//
//  RecipeViewModel.swift
//  recipeApp
//
//  Created by Jonathan Novecio on 7/19/24.
//

import Foundation

final class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe?
    @Published var isSuccess = false
    @Published var isLoading = true
    
    func fetchRecipe(id: String) {
        self.isLoading = true
        let userUrlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=" + id
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
                               let recipes = try? decoder.decode(RecipesResponse.self, from: data) {
                                
                                self?.recipe = recipes.meals[0]
                                self?.isSuccess = true
                                self?.isLoading = false
                            } else {
                                self?.isSuccess = false
                                self?.isLoading = false
                                print("Failed")
                            }
                        }
                    }
                }.resume()
        }
    }
    
    func mapIngredientsToMeasurements(meal: Recipe) -> [String: String] {
        var ingredientsDict: [String: String] = [:]
        let mirror = Mirror(reflecting: meal)
        
        for case let (label?, value) in mirror.children {
            if label.hasPrefix("strIngredient"), let ingredientNumber = label.suffix(1).first {
                let measureLabel = "strMeasure\(ingredientNumber)"
                if let measureValue = mirror.children.first(where: { $0.label == measureLabel })?.value as? String {
                    if (value as! String) != "" {
                        ingredientsDict[value as! String] = measureValue
                    }
                }
            }
        }
        return ingredientsDict
    }
    
    func processInstructions(meal: Recipe) -> [String] {
        var instructions = meal.strInstructions.components(separatedBy: "\n").filter {!$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty}
        return instructions
    }
}


