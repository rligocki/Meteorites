//
//  MeteoriteRowView.swift
//  Meteorites
//
//  Created by Roman Ligocki on 18.04.2021.
//

import SwiftUI

struct MeteoriteRowView: View {
    let meteorite: Meteorite
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.accentColor
            HStack {
                CircleView(mass: meteorite.mass)
                TitleView(name: meteorite.name,
                          recLat: meteorite.recLat,
                          recLong: meteorite.recLong)
            }
            .padding(15)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct TitleView: View {
    let name: String
    let recLat: Double
    let recLong: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(name)")
                .foregroundColor(.white)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(2)
                .padding(.bottom, 5)
            
            if recLong != 0 && recLat != 0 {
                Text("\(recLat)°")
                    .foregroundColor(.white)
                Text("\(recLong)°")
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
            } else {
                Text("No position")
            }
            
        }
        .padding(.horizontal, 5)
    }
}

struct CircleView: View {
    let mass: Double
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
            VStack {
                Text(String(format: "%.2f", mass / 1000))
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.black)
                Text("kg")
                    .font(.caption)
                    .foregroundColor(.black)
            }
        }
        .frame(width: 70, height: 70, alignment: .center)
    }
}
