//
//  MapView.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var meteorite: Meteorite
    @State var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: [meteorite.location],
            annotationContent: { (location) -> MapPin in
                MapPin(coordinate: location.coordinate, tint: .blue)
            })
            .edgesIgnoringSafeArea(.all)
            .navigationTitle(meteorite.name)
    }
}
