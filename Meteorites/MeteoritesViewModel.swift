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
    let defaults = UserDefaults.standard
    
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
                fatalError("Realm: Failed to start db")
            }
        }
        
        self.meteorites = Array(realm.objects(Meteorite.self))
        
        if defaults.double(forKey: "last-update") < Date().timeIntervalSinceReferenceDate - 24 * 60 * 60 {
            defaults.set(Date().timeIntervalSinceReferenceDate, forKey: "last-update")
            fetchData()
        }
    }
    
    func fetchData() {
        var fetchURL = URLComponents(string: baseURL)!
        fetchURL.queryItems = [URLQueryItem(name: "$$app_token", value: "FlXstmJ3UJxqDW86oL7bOFHVk"),
                               URLQueryItem(name: "$where", value: "year >= \"2011-01-01T00:00:00.000\"")]
        
        let request = URLRequest(url: fetchURL.url!)
        
        URLSession(configuration: URLSessionConfiguration.ephemeral).dataTaskPublisher(for: request)
            .timeout(.milliseconds(2000), scheduler: DispatchQueue.main, options: .none, customError: {
                return URLSession.DataTaskPublisher.Failure(_nsError: NSError())
            })
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [Meteorite].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.showError(message: "URLSession: HTTP connection timeout", color: .yellow)
                case .finished:
                    do {
                        try self.realm.write {
                            self.realm.deleteAll()
                            for meteorite in self.meteorites {
                                self.realm.add(meteorite)
                            }
                        }
                    } catch {
                        self.showError(message: "Database: Failed to write data", color: .red)
                    }
                }
            },
            receiveValue: { meteorites in
                self.meteorites = meteorites
                self.meteorites.sort()
            })
            .store(in: &self.storage)
    }
    
    func showError(message: String, color: UIColor) {
        animateAndDelayWithSeconds(0.5) { [self] in
            self.errorMessage = message
            self.errorColor = color
            self.showError = true
        }
        animateAndDelayWithSeconds(4) { self.showError = false }
    }
    
    func animateAndDelayWithSeconds(_ seconds: TimeInterval, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            withAnimation(.easeInOut) {
                action()
            }
        }
    }
}
