//
//  MeteoritesManager.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import Foundation
import RealmSwift

class MeteoritesViewModel: ObservableObject {
    let realm = try! Realm()
    
    @Published var meteorites: [Meteorite] = [
        Meteorite(name: "1", mass: 10, year: 1900, lat: 0, long: 1),
        Meteorite(name: "2", mass: 10, year: 2000, lat: 1, long: 0),
        Meteorite(name: "3", mass: 20, year: 2100, lat: 2, long: -1)
    ]
    
    init(){
        meteorites = Array(realm.objects(Meteorite.self))
    }
    
}
