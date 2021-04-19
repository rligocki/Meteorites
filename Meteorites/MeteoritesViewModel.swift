//
//  MeteoritesManager.swift
//  Meteorites
//
//  Created by Roman Ligocki on 16.04.2021.
//

import Foundation
import RealmSwift
import Combine
import SwiftUI

class MeteoritesViewModel: ObservableObject {
    let realm: Realm
    
    let baseURL: String = "https://data.nasa.gov/resource/gh4g-9sfh.json"
    var storage = Set<AnyCancellable>()
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = "Error"
    @Published var errorColor: UIColor = .red
    @Published var meteorites: [Meteorite] = []
    
    init() {
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
    
    func fetchData() {
        var fetchURL = URLComponents(string: baseURL)!
        fetchURL.queryItems = [URLQueryItem(name: "$$app_token", value: "FlXstmJ3UJxqDW86oL7bOFHVk"),
                               URLQueryItem(name: "$where", value: "year >= \"2011-01-01T00:00:00.000\"")]
        
        let request = URLRequest(url: fetchURL.url!)
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [Meteorite].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [self]_ in
                do {
                    try self.realm.write {
                        self.realm.deleteAll()
                        
                        for meteorite in self.meteorites {
                            self.realm.add(meteorite)
                        }
                    }
                } catch {
                    showError(message: "Databse: Failed to write data", color: .red)
                }
            },
            receiveValue: { meteorites in
                self.meteorites = meteorites
                self.meteorites.sort()
            })
            .store(in: &self.storage)
    }
    
    func showError(message: String, color: UIColor) {
        self.animateAndDelayWithSeconds(0.5) {
            self.errorMessage = message
            self.errorColor = color
            self.showError = true
        }
        self.animateAndDelayWithSeconds(4) { self.showError = false }
    }
    
    func animateAndDelayWithSeconds(_ seconds: TimeInterval, action: @escaping () -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                withAnimation(.easeInOut) {
                    action()
                }
            }
        }
}
