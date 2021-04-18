//
//  MeteoritesManager.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import Foundation
import RealmSwift
import Combine

class MeteoritesViewModel: ObservableObject {
    let realm: Realm
    let baseURL: String = "https://data.nasa.gov/resource/gh4g-9sfh.json"
    var storage = Set<AnyCancellable>()
    
    @Published var meteorites: [Meteorite] = []
    
    init(){
        do {
            realm = try Realm()
        } catch {
            var deleteManager = Realm.Configuration()
            deleteManager.deleteRealmIfMigrationNeeded = true
            do {
                realm = try Realm(configuration: deleteManager)
            } catch {
                fatalError("Failed to instantiate: \(error.localizedDescription)")
            }
        }
        
        self.meteorites = Array(realm.objects(Meteorite.self))
        
        fetchData()
    }
    
    func fetchData(){
        var fetchURL = URLComponents(string: baseURL)!
        fetchURL.queryItems = [URLQueryItem(name: "$$app_token", value: "FlXstmJ3UJxqDW86oL7bOFHVk"),
                               URLQueryItem(name: "$where", value: "year >= \"2013-01-01T00:00:00.000\"")]
        
        let request = URLRequest(url: fetchURL.url!)
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [Meteorite].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
                print ("Received completion: \($0).")
                try! self.realm.write {
                    self.realm.deleteAll()

                    for meteorite in self.meteorites {
                        self.realm.add(meteorite)
                    }
                }
            },
            receiveValue: { meteorites in
                self.meteorites = meteorites
                self.meteorites.sort()
            })
            .store(in:&self.storage)
    }
}
