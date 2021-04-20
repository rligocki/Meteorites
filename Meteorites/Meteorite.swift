//
//  MeteoriteModel.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import Foundation
import MapKit
import RealmSwift

final class Meteorite: Object, Identifiable, Decodable, Comparable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var mass: Double = 0.0
    @objc dynamic var year: String = ""
    @objc dynamic var fall: String = ""
    @objc dynamic var recLat: Double = -180
    @objc dynamic var recLong: Double = -180
    
    var yearInt: Int {
        let dateFormatterGet = DateFormatter()
        let calendar = Calendar.current
        
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        guard let date = dateFormatterGet.date(from: year) else { return -1 }
        
        return calendar.component(.year, from: date)
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
    
    enum CodingKeys: String, CodingKey {
        case name, mass, year, fall, reclat, reclong
    }
    
    override init() {
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    
        guard let massDouble = Double(try values.decode(String.self, forKey: .mass)) else { fatalError()}
        guard let recLatDouble = Double(try values.decode(String.self, forKey: .reclat)) else { fatalError() }
        guard let recLongDouble = Double(try values.decode(String.self, forKey: .reclong)) else { fatalError() }
        
        mass = massDouble
        recLat = recLatDouble
        recLong = recLongDouble
        
        year = try values.decode(String.self, forKey: .year)
        name = try values.decode(String.self, forKey: .name)
        fall = try values.decode(String.self, forKey: .fall)
    }
    
    static func < (lhs: Meteorite, rhs: Meteorite) -> Bool {
        return lhs.mass > rhs.mass
    }
}
