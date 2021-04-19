//
//  MeteoriteModel.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import Foundation
import MapKit
import RealmSwift

final class Meteorite: Object, Identifiable, Decodable, Comparable{
    
    
    @objc dynamic var name: String
    @objc dynamic var mass: Double
    @objc dynamic var year: Int
    @objc dynamic var fall: String
    @objc dynamic var recLat: Double
    @objc dynamic var recLong: Double
    
    enum CodingKeys: String, CodingKey {
        case name, mass, year, fall, reclat, reclong
    }
    
    var region: MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: recLat,
                                                                 longitude: recLong),
                                  span: MKCoordinateSpan(latitudeDelta: 0.5,
                                                         longitudeDelta: 0.5))
    }
    var location: Location {
        return Location(title: name,
                        coordinate: CLLocationCoordinate2D(latitude: recLat,
                                                           longitude: recLong))
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
    
    init(name: String, mass: Double, year: Int, fall: String, lat: Double, long: Double){
        self.name = name
        self.mass = mass
        self.year = year
        self.fall = fall
        self.recLat = 0
        self.recLong = 0
    }
    
    override init(){
        self.name = "TestName"
        self.mass = 1
        self.year = 69
        self.fall = "Found"
        self.recLat = 0
        self.recLong = 0
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let massDouble = Double(try (values.decodeIfPresent(String.self, forKey: .mass) ?? "0.0") )
        let recLatDouble = Double(try values.decodeIfPresent(String.self, forKey: .reclat) ?? "37.2431")
        let recLongDouble = Double(try values.decodeIfPresent(String.self, forKey: .reclong) ?? "115.7930")
        let stringYear = try values.decodeIfPresent(String.self, forKey: .year) ?? "1969"
        
        year = Meteorite.convert(year: stringYear) ?? 0
        mass = massDouble ?? 0
        recLat = recLatDouble ?? 37.2431
        recLong = recLongDouble ?? 115.7930
        
        name = try values.decode(String.self, forKey: .name)
        fall = try values.decode(String.self, forKey: .fall)
    }
    
    static func < (lhs: Meteorite, rhs: Meteorite) -> Bool {
        return lhs.mass > rhs.mass
    }
    
    static func convert(year: String) ->  Int? {
        let dateFormatterGet = DateFormatter()
        let calendar = Calendar.current
        
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        guard let date = dateFormatterGet.date(from: year) else { return -1 }
        
        return calendar.component(.year, from: date)
    }
}

