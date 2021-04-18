//
//  MeteoriteRowView.swift
//  Meteorites
//
//  Created by Roman Ligocki on 18.04.2021.
//

import SwiftUI


extension Color {
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }

//    public static var flatPurpleDarkBackground: Color {
//        return Color(decimalRed: 50, green: 0, blue: 50)
//    }
//
//    public static var flatPurpleDarkCardBackground: Color {
//        return Color(decimalRed: 70, green: 0, blue: 70)
//    }
    
    public static var brown: Color {
        return Color(decimalRed: 90, green: 50, blue: 0)
    }
}

struct MeteoriteRowView: View {
    
    let meteorite: Meteorite
    
    var body: some View {
        ZStack(alignment: .leading) {

            Color.purple
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

struct TitleView: View{
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
                //                    HStack {
                //                        Metadata(name: "\(meteorite.fall)")
                //                    }
            }

        }
        .padding(.horizontal, 5)
    }
}

struct CircleView: View{
    let mass: Double

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.brown)

            VStack {
                Text("\(mass)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                Text("kg")
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 70, height: 70, alignment: .center)
    }
}

struct MetadataView: View {

    let name: String
    let fontSize: CGFloat = 12.0

    var body: some View {
        ZStack {
            Text(name)
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(2)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.green)
                .cornerRadius(5)
        }
    }
}
