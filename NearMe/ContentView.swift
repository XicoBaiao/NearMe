//
//  ContentView.swift
//  NearMe
//
//  Created by Baiao, Francisco Fonseca on 13/07/2022.
//

import SwiftUI
import MapKit
import NearMeNetwork

enum DisplayType {
    case map
    case list
}

struct ContentView: View {
    var isHidden: Bool = false
    
    @State  var swiftyColor: Color = .red
    @State  var fontSize: Double = 10
    @State  var tapped: Bool = false
    
    var locationManager = LocationManager()
    
    @ObservedObject var viewModel: PlaceListViewModel
    @State var userTrackingMode : MapUserTrackingMode = .follow
    @State var displayType: DisplayType = .map
    @State var isDragged: Bool = false
    
    @State var search: String = ""
        
    private func getNearbyLandmarks() {
        
        guard let location = self.locationManager.location else {return}
        
        let search = viewModel.fetchLandmarks(query: search)
        
    }
    
    private func getRegion() -> Binding<MKCoordinateRegion> {
        
        
        guard let coordinate = viewModel.currentLocation else {
            return .constant(MKCoordinateRegion.defaultRegion)
        }
        
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        
        return .constant(MKCoordinateRegion.defaultRegion)
        
    }
    
    func calculateOffset() -> CGFloat {
        
        if self.viewModel.locations.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height/4
        } else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
        
    }
    
    var body: some View {
        
        
        VStack {
            
            TextField("Search", text: $search, onEditingChanged: { _ in
                
            }, onCommit: {
                viewModel.fetchLandmarks(query: search)
            }).textFieldStyle(.roundedBorder)
            
            LandmarkCategoryView { (category) in
                viewModel.fetchLandmarks(query: category)
            }
            
            Picker("Select", selection: $displayType) {
                Text("Map").tag(DisplayType.map)
                Text("List").tag(DisplayType.list)
            }.pickerStyle(SegmentedPickerStyle())
            
            if displayType == .map {
                
                
                Map(coordinateRegion: getRegion(), interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: viewModel.locations) { location in
                    MapMarker(coordinate: location.coordinate)
                    
                }
                .overlay(AnyView(RecenterButton {
                    viewModel.startUpdatingLocation()
                    isDragged = false
                }.padding()),alignment: .bottom)
                
                
            } else if displayType == .list {
                
                LandmarkListView(locations: viewModel.locations)
                
            }
        }.padding()
            
            
        
//        VStack {
//            Image(systemName: "swift")
//                .resizable()
//                .frame(width: 100.0, height: 100.0)
//                .background(Color.blue)
//                .padding([.leading, .bottom, .trailing], 15.0)
//            Text("Howdy, world!")
//                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                .kerning(5.0)
//                .padding()
//
//        }
        
        
        
        //MAP WITH PLACES AND MAPKIT
        
//        ZStack(alignment: .top) {
//
//
//            NearMeMapView(landmarks: self.landmarks)
//                .ignoresSafeArea()
//
//            TextField("Search", text: self.$search, onEditingChanged: { _ in }) {
//
//                self.getNearbyLandmarks()
//
//            }.textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//                .offset(y: 44)
//
//            PlaceListView(landmarks: self.landmarks) {
//
//                self.tapped.toggle()
//
//
//            }
//            .offset(y: calculateOffset())
//            .animation(.spring())
//        }
        
        
        
        
        
        
        
//        VStack(spacing: 70.0) {
//            SwiftyControls(swiftyColor: $swiftyColor, fontSize: $fontSize)
//
//            HStack(alignment: .center, spacing: 5.0) {
//                Button("Continue", action: {})
//                    .modifier(CustomModifier(swiftyColor: $swiftyColor, fontSize: $fontSize))
//                Button("More details", action: {})
//                    .modifier(CustomModifier(swiftyColor: $swiftyColor, fontSize: $fontSize))
//                Button("Cancel", action: {})
//                    .modifier(CustomModifier(swiftyColor: $swiftyColor, fontSize: $fontSize))
//            }
//        }
//        .padding(.horizontal, 20.0)
        
        
    }
}

struct CustomModifier: ViewModifier {
    
    @Binding var swiftyColor: Color
    @Binding var fontSize: Double
    
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.white)
            .font(.system(size: fontSize))
            .padding(.horizontal, 14)
            .padding(.vertical,10)
            .background(swiftyColor)
            .overlay(RoundedRectangle(cornerRadius: 3)
                .strokeBorder(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(Color(.init(srgbRed: 0.1, green: 0.1, blue: 0.1, alpha: 1))))
            .cornerRadius(10)
            .shadow(color: .init(.init(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)), radius: 5, x: 0, y: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PlaceListViewModel())
    }
}

struct SwiftyControls: View {
    @Binding var swiftyColor: Color
    @Binding var fontSize: Double
    
    var body: some View {
        VStack {
            ColorPicker("Swifty Color", selection: $swiftyColor)
                .padding(.all, 16.0)
            Slider(value: $fontSize, in : 10...25)
                .padding(.all, 16.0)
                .accentColor(swiftyColor)
        }
    }
}
