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
    
    @State private var locationManager = LocationManager()
    
    @ObservedObject var viewModel: PlaceListViewModel
    @State var userTrackingMode : MapUserTrackingMode = .follow
    @State var displayType: DisplayType = .map
    @State var isDragged: Bool = false
    
    @State private var search: String = ""
    
    @State private var landmarks = [Landmark]()
    @State private var landmarkIsSelected: Bool = false
    @State var selectedLandmark = LandmarkViewModel(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 10))) 
    @State private var mapType: MKMapType = .standard
    
    private func getNearbyLandmarks() {
        
        guard let location = self.locationManager.location else {return}
        
        let search = viewModel.fetchLandmarks(query: search)
        
    }
    
    private func getRegion() -> Binding<MKCoordinateRegion> {
        
        if landmarkIsSelected {
            return .constant(MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: selectedLandmark.coordinate.latitude - 0.001, longitude: selectedLandmark.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
        }
        
        guard let coordinate = viewModel.currentLocation else {
            return .constant(MKCoordinateRegion.defaultRegion)
        }
        
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)))
        
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
            
//            Picker("Select", selection: $mapType) {
//                Text("Standard").tag(MKMapType.standard)
//                Text("Satellite").tag(MKMapType.satellite)
//                Text("Hybrid").tag(MKMapType.hybrid)
//            }.pickerStyle(SegmentedPickerStyle())
//
            ZStack {
                if displayType == .map {
                    
                    Map(coordinateRegion: getRegion(), interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: placeListVM.landmarks) { landmark in
                        MapAnnotation(coordinate: landmark.coordinate) {
                            PlaceAnnotationView(landmark: landmark, selectedLandmark: $selectedLandmark, locationManager: $locationManager,
                                                landmarkIsSelected: $landmarkIsSelected)
                        }
                        //                    MapMarker(coordinate: landmark.coordinate)
                    }
                    .if(!selectedLandmark.name.isEmpty) {$0.overlay(AnyView(LocationPreviewView(location:selectedLandmark, locationManager: locationManager, googlePlaceManager: GooglePlacesManager.shared)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))).offset(y:-20),alignment: .bottom)}
                    
                    
                    //                    .overlay(AnyView(RecenterButton {
                    //                        placeListVM.startUpdatingLocation()
                    //                        isDragged = false
                    //                    }.padding()),alignment: .bottom)
                    
//                    ZStack {
//                        LocationPreviewView(location: LandmarkViewModel(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 10))))
//                            .shadow(color: Color.black.opacity(0.3), radius: 20)
//                            .padding()
//                    }
                    
                    
                } else if displayType == .list {
                    
                    LandmarkListView(landmarks: placeListVM.landmarks.sorted(by: {$0.distanceToUserInMeters(locationManager: locationManager) < $1.distanceToUserInMeters(locationManager: locationManager)}),
                                     locationManager: locationManager, displayType: $displayType,
                    selectedLandmark: $selectedLandmark,
                    landmarkIsSelected: $landmarkIsSelected)
                    
                }
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

struct PlaceAnnotationView: View {
    
  var landmark: LandmarkViewModel
  @Binding var selectedLandmark: LandmarkViewModel
  @Binding var locationManager: LocationManager
  @Binding var landmarkIsSelected: Bool
    
  var body: some View {
    VStack(spacing: 0) {
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.red)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.red)
        .offset(x: 0, y: -5)
    }.onTapGesture {
        selectedLandmark = landmark
        landmarkIsSelected = true
        GooglePlacesManager.shared.findPlacePhoto(place: selectedLandmark)
    }
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
