//
//  MeteoriteModel.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import Foundation
import MapKit
import RealmSwift

class Meteorite: Object, Identifiable{
    @objc dynamic var name: String
    @objc dynamic var mass: Int
    @objc dynamic var year: Int
    @objc dynamic var fall: String
    @objc dynamic var geolocationLat: Double
    @objc dynamic var geolocationLong: Double
    
    var region: MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: geolocationLat,
                                                                 longitude: geolocationLong),
                                  span: MKCoordinateSpan(latitudeDelta: 0.5,
                                                         longitudeDelta: 0.5))
    }
    
//    dynamic let id: String
//    dynamic let nameType: String
//    dynamic let recClass: String
//    dynamic let recLat: String
//    dynamic let recLong: String
//    dynamic let geolocationAddress: String
//    dynamic let geolocationCity: String
//    dynamic let geolocationState: String
//    dynamic let geolocationZip: String
    
    init(name: String, mass: Int, year: Int, fall: String, lat: Double, long: Double){
        self.name = name
        self.mass = mass
        self.year = year
        self.fall = fall
        self.geolocationLat = 0
        self.geolocationLong = 0
    }
    
    override init(){
        self.name = "TestName"
        self.mass = 1
        self.year = 69
        self.fall = "Found"
        self.geolocationLat = 0
        self.geolocationLong = 0
    }
    
    static func convert(year: String) ->  Int {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-ddTHH:mm:ss.SSS"
        guard let date = dateFormatterGet.date(from: "1880-01-01T00:00:00.000") else { return -1 }
        
        print(date)
        
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
}
