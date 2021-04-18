//
//  ContentView.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import SwiftUI

struct MeteoritesView: View {
    
    @ObservedObject var meteoritesModel = MeteoritesViewModel()
    
    var body: some View {
        NavigationView {
            List(meteoritesModel.meteorites) { meteorite in
                NavigationLink(destination: MapView(region: meteorite.region)) {
                    MeteoriteRowView(meteorite: meteorite)
                }.disabled(meteorite.fall != "Found" || (meteorite.recLat == 0 && meteorite.recLong == 0))
            }.navigationBarTitle("Meteorites", displayMode: .inline)
        }
    }
}
