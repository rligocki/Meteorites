//
//  MeteoritesManager.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import Foundation
import RealmSwift
import Alamofire

class MeteoritesViewModel: ObservableObject {
    let realm: Realm
    let baseURL: String = "https://data.nasa.gov/resource/gh4g-9sfh.json"
    let parameters: Parameters = [
        "$$app_token": "FlXstmJ3UJxqDW86oL7bOFHVk",
        "$where": "year >= \"2011-01-01T00:00:00.000\"",
        "$order": "mass DESC"
    ]
    
    @Published var meteorites: [Meteorite] = []
    
    init(){
        realm = try! Realm()
        
        meteorites = Array(realm.objects(Meteorite.self))
        
        fetchData()
    }
    
    func fetchData(){
        let request = AF.request(baseURL,
                                 method: .get,
                                 parameters: parameters)
            request.responseJSON { (data) in
              print(data)
            }
    }
    
}
