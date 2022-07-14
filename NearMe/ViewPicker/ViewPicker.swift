//
//  ViewPicker.swift
//  NearMe
//
//  Created by Nicolá Domingues on 14/07/2022.
//

import SwiftUI

struct ViewPicker: View {
    @State private var isCategoriesSelected = true
    var body: some View {
        ZStack {
            if !isCategoriesSelected {
                Button {
                    print("123")
                } label: {
                    VStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 8)
                            .padding()
                            .frame(maxHeight: 100)
                        Spacer()
                    }
                }

            } else {
                ForEachTutorial()
            }
            
            VStack {
                Picker(selection: $isCategoriesSelected, label: Text("Picker")) {
                    Text("Categories")
                        .tag(true)
                    Text("Map")
                        .tag(false)
                }
                .pickerStyle(.segmented)
                .padding()
                Spacer()
            }
        }
    }
}

struct ViewPicker_Previews: PreviewProvider {
    static var previews: some View {
        ViewPicker()
    }
}
