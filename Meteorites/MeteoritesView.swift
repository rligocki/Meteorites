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
                NavigationLink(destination: MapView(meteorite: meteorite, region: meteorite.region)) {
                    MeteoriteRowView(meteorite: meteorite)
                }.disabled(meteorite.recLat == 0 && meteorite.recLong == 0)
            }
            .navigationBarTitle("Meteorites list",displayMode: .inline)
            .toolbar {
                Text("Total: \(meteoritesModel.meteorites.count)")
            }
        }
    }
}
