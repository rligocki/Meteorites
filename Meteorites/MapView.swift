//
//  MapView.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region)
            
    }
}
