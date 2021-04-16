//
//  ContentView.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import SwiftUI

struct MeteoritesView: View {
    
    let meteoritesModel = MeteoritesViewModel()
    
    var body: some View {
        NavigationView {
            List(meteoritesModel.meteorites) { meteorite in
                NavigationLink(destination: MapView(region: meteorite.region)) {
                    Text(meteorite.name)
                }
            }
        }
    }
}
