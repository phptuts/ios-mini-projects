//
//  ContentView.swift
//  ParkFinder
//
//  Created by Noah Glaser on 8/21/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject var manager = LocationManager()

    var body: some View {
        NavigationView {
            VStack {
                Map(
                    coordinateRegion: $manager.region,
                    showsUserLocation: true,
                    annotationItems: manager.annonations
                ) { location in
                    MapAnnotation(coordinate: location.cooridinate) {
                        VStack {
                            ZStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color("AccentColor"))
                                Image(systemName: "car.circle")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    
                            }
                            Text(location.createdAt.formatted(date: .omitted, time: .shortened))
                            // Fixed save makes it so that it does not get cut with ...
                                .fixedSize()
                        }.accessibilityElement(children: .ignore)
                            .accessibilityLabel("You parked here at \(location.createdAt.formatted(date: .omitted, time: .shortened))")
                        
                    }
                }
                // when the app re appears from the background center back to where the user is
                // https://stackoverflow.com/a/70299520
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    manager.recenter = true
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        manager.save()
                    } label: {
                        Image(systemName: "parkingsign.circle")
                            .foregroundColor(Color("AccentColor"))
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Set parked location")

                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        openDirections()
                    } label: {
                        Image(systemName: "figure.walk")
                            .foregroundColor(manager.annonations.isEmpty ? .gray : .green)
                    }.disabled(manager.annonations.isEmpty)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Get direction to where you parked")
                }
            }.navigationTitle("Last Parked Space")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func openDirections() {
        
        guard let location = manager.annonations.first else { return }
        
        let url = URL(string: "maps://?saddr=&daddr=\(location.latitude),\(location.longitude)")!
        manager.recenter = true
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
