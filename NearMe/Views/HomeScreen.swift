//
//  HomeScreen.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 28/07/2022.
//

import SwiftUI

struct HomeScreen: View {
    
    init() {
//        UIScrollView.appearance().backgroundColor = UIColor.init(red: 62/255, green: 180/255, blue: 137/255, alpha: 0.8)
        UIScrollView.appearance().backgroundColor = UIColor.black
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.blue]
    }
    
    var body: some View {
        let categories: [Category] = Bundle.main.decode("categories.json")
            NavigationView {
                    List {
                        HomeScreenImageView()
                            .frame(height: 300)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        ForEach(categories) { category in
                            CategoryListItemView(category: category)
                        }.listRowBackground(Color.init(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.5))
                    }.navigationBarTitle("Near Me", displayMode: .large)
            }
    }
    
    private var splashImageBackground: some View {
            GeometryReader { geometry in
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width)
            }
        }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
