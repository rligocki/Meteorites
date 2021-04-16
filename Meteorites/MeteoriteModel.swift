//
//  MeteoriteModel.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import Foundation
import MapKit
import Realm
import RealmSwift

class Meteorite: Object{
    
    dynamic let name: String
    dynamic let mass: Int
    dynamic let year: Int
    dynamic let geolocation: CLLocationCoordinate2D
//    dynamic let id: String
//    dynamic let nameType: String
//    dynamic let recClass: String
//    dynamic let fall: String
//    dynamic let recLat: String
//    dynamic let recLong: String
//    dynamic let geolocationAddress: String
//    dynamic let geolocationCity: String
//    dynamic let geolocationState: String
//    dynamic let geolocationZip: String
    
    init(name: String, mass: Int, year: Int, geolocation: CLLocationCoordinate2D){
        self.name = name
        self.mass = mass
        self.year = year
        self.geolocation = geolocation
    }
}
