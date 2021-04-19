//
//  Location.swift
//  Meteorites
//
//  Created by Roman Ligocki on 19.04.2021.
//

import Foundation
import MapKit

struct Location: Identifiable{
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
}
