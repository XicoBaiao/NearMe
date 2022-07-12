//
//  ForEachTutorial.swift
//  SwiftUiTutorial
//
//  Created by Baiao, Francisco Fonseca on 12/07/2022.
//

import SwiftUI

struct ForEachTutorial: View {
    
    @State var items = ["1241241", "1235135", "3241", "24124124"]
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 3)
    
    @State private var categoryColor: Color = .red
    @State private var categoryImage: UIImage = UIImage(named: "Gas_Station")!
    @State private var categoryTitle: String = "Default"
    
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 15.0) {
                Text("Near Me")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(width: 1, height: 50, alignment: .center)
                LazyVGrid(columns: columns, spacing: 35) {
                    ForEach(0..<15) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(Color(.sRGB, red: 0.960, green: 0.866, blue: 0.458, opacity: 0.5))
                                .frame(width: 110, height: 140, alignment: .center)
                            VStack {
                                Image("Gas_Station")
                                    .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 75, height: 75, alignment: .center)
                                Spacer()
                                    .frame(width: 15, height: 10, alignment: .center)
                                Text("Gas Station")
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 100, height: 25, alignment: .center)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                        .padding(.horizontal, 15.0)
                    }
                }
            }
        }
        }
    }

//struct CategoryModifier: ViewModifier {
//
//    @Binding private var categoryColor: Color
//    @Binding private var categoryImage: UIImage
//    @Binding private var categoryTitle: String
//
//    func body(content: Content) -> some View {
//        return content
//            .foregroundColor(.white)
//            .font(.system(size: fontSize))
//            .padding(.horizontal, 14)
//            .padding(.vertical,10)
//            .background(swiftyColor)
//            .overlay(RoundedRectangle(cornerRadius: 3)
//                .strokeBorder(style: StrokeStyle(lineWidth: 1))
//                .foregroundColor(Color(.init(srgbRed: 0.1, green: 0.1, blue: 0.1, alpha: 1))))
//            .cornerRadius(10)
//            .shadow(color: .init(.init(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)), radius: 5, x: 0, y: 0)
//    }
//}

struct ForEachTutorial_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEachTutorial()
                .previewDevice("iPhone SE (3rd generation)")
            ForEachTutorial()
                .previewDevice("iPhone 13 Pro Max")
        }
        
    }
}
