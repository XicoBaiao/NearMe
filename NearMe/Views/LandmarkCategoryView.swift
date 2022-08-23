//
//  LandmarkCategoryView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 20/07/2022.
//

import SwiftUI

struct LandmarkCategoryView: View {
    
    let categories = ["Bombas", "Supermercados", "Cafés", "Farmácias", "Hotéis","Bares", "Take-Away", "Restaurantes"]
    let onSelectedCategory: (String) -> ()
    @State private var selectedCategory : String = ""
    
    var body: some View {
        ScrollView(.horizontal) {
            
            HStack {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                        onSelectedCategory(category)
                    }, label: {
                        Text(category)
                    }).padding(10)
                        .foregroundColor(selectedCategory == category ? Color.white : Color.gray)
                        .background(selectedCategory == category ? Color(.systemGray2) : Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                }
            }
            
        }
    }
}

struct LandmarkCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkCategoryView(onSelectedCategory: { _ in})
    }
}
