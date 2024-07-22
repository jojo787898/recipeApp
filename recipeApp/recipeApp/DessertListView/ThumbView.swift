//
//  ThumbView.swift
//  recipeApp
//
//  Created by Jonathan Novecio on 7/15/24.
//

import SwiftUI

struct ThumbView: View {
    let meal: Meal
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 180, height: 273, alignment: .top)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
            .overlay(alignment: .bottom) {
                Text(meal.strMeal)
                    .font(.headline)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3, x: 0, y: 0)
                    .frame(maxWidth: 200)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbView(meal: Meal(idMeal: "sdfasf", strMeal: "asdfaf", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
    }
}
