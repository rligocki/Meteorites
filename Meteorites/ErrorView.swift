//
//  ErrorView.swift
//  Meteorites
//
//  Created by Roman Ligocki on 19.04.2021.
//

import SwiftUI

struct ErrorView: View {
    @State var text: String
    @State var color: UIColor
    @Binding var show: Bool
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if show {
                    Text("\(text)")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(width: geometry.size.width * 0.95, height: 44.0)
                        .background(Color(color))
                        .cornerRadius(8)
                    }
                    Spacer()
                }
            }
        }
    }
}
