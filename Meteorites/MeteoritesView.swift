//
//  ContentView.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import SwiftUI

struct MeteoritesView: View {
    @ObservedObject var meteoritesViewModel = MeteoritesViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                
                List(meteoritesViewModel.meteorites) { meteorite in
                    NavigationLink(destination: MapView(meteorite: meteorite, region: meteorite.region)) {
                        MeteoriteRowView(meteorite: meteorite)
                    }.disabled(meteorite.recLat == 0 && meteorite.recLong == 0)
                }
                .navigationBarTitle("Meteorites list", displayMode: .inline)
                .toolbar {
                    Text("Total: \(meteoritesViewModel.meteorites.count)")
                }
            }
            ErrorView(text: meteoritesViewModel.errorMessage,
                          color: meteoritesViewModel.errorColor,
                          show: $meteoritesViewModel.showError)
        }
    }
}
