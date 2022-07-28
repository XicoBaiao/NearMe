//
//  CategoryListItemView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 28/07/2022.
//

import SwiftUI

struct CategoryListItemView: View {
    
    let category: Category
    
    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            Image(category.image)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(
                RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(category.name)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Text(category.headline)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .padding(.trailing, 8)
            }
        }
    }
}

struct CategoryListItemView_Previews: PreviewProvider {
    static let categories : [Category] = Bundle.main.decode("categories.json")
    
    static var previews: some View {
        CategoryListItemView(category: categories[1])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
