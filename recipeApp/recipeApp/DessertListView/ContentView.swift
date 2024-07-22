//
//  ContentView.swift
//  recipeApp
//
//  Created by Jonathan Novecio on 7/15/24.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @StateObject private var vm = MealsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 5)], spacing: 10) {
                    ForEach(vm.mealList, id:\.idMeal) {meal in
                        NavigationLink(destination: RecipeView(mealId: meal.idMeal)) {
                            ThumbView(meal: meal)
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Dessert Recipe List")
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: vm.fetchMeals)
    }
}

