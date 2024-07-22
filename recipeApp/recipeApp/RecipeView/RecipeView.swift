//
//  DetailView.swift
//  recipeApp
//
//  Created by Jonathan Novecio on 7/15/24.
//

import SwiftUI

struct RecipeView: View {
    let mealId: String
    @StateObject var vm = RecipeViewModel()
    
    var body: some View {
        VStack {
            if vm.isLoading {
                ProgressView()
            } else if vm.isSuccess {
                AsyncImage(url: URL(string: vm.recipe!.strMealThumb)) {image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(alignment: .top) {
                            Text(vm.recipe!.strMeal)
                                .font(.title2)
                                .foregroundColor(.black)
                                .shadow(color: .black, radius: 3, x: 0, y: 0)
                                .frame(maxWidth: 200)
                                .padding()
                        }
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 350, height: 300, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .offset(y: -30)
                TabView {
                    IngredientView(ingredientDict: vm.mapIngredientsToMeasurements(meal: vm.recipe!))
                        .tabItem {
                            Label("", systemImage: "list.dash")
                        }
                    
                    InstructionView(instructions: vm.processInstructions(meal: vm.recipe!))
                        .tabItem {
                            Label("", systemImage: "square.and.pencil")
                        }
                }
            } else {
                Text("Failed to load")
            }
        }
        .onAppear {
            vm.fetchRecipe(id: mealId)
        }
    }
}

struct IngredientView: View {
    let ingredientDict: [String: String]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                Text("Ingredients")
                    .font(.headline)
                ForEach(ingredientDict.sorted(by: { $0.key < $1.key }), id: \.key) { ingredient, measure in
                    HStack {
                        Text(measure + " " + ingredient)
                            .foregroundColor(.primary)
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

struct InstructionView: View {
    let instructions: [String]
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                ForEach(Array(instructions.enumerated()), id: \.offset) { offset, instruction in
                    HStack {
                        Text(String(offset + 1) + ". " + instruction.trimmingCharacters(in: .whitespacesAndNewlines))
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}


//struct RecipeView_Previews: PreviewProvider {
//    static var previews: some View {
////        IngredientView(ingredientDict: ["Oil": "60ml", "Unsalted Butter": "25g", "Eggs": "2", "Baking Powder": "3 tsp", "Sugar": "45g", "Flour": "1600g", "Peanut Butter": "3 tbs", "Milk": "200ml", "Salt": "1/2 tsp"])
////        InstructionView
//    }
//}
