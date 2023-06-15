//
//  UserDefaultable.swift
//  Busy
//
//  Created by Dylan Elliott on 15/6/2023.
//

import Foundation

enum DefaultsKey: String, CaseIterable {
    case urlScheme = "URL_SCHEME"
}

func getFromUserDefaults<T: Codable>(for key: DefaultsKey) -> T? {
    guard let data = SharedDefaults.data(for: key) else { return nil }
    return (try? JSONDecoder().decode(T.self, from: data))
}

func saveToUserDefaults<T: Codable>(_ value: T, forKey key: DefaultsKey) {
    guard let data = try? JSONEncoder().encode(value) else { return }
    SharedDefaults.set(data: data, for: key)
    SharedDefaults.synchronize()
}

var SharedDefaults: DefaultsStore { UserDefaults.standard }

protocol DefaultsStore {
    func set(data: Data?, for key: DefaultsKey)
    func data(for key: DefaultsKey) -> Data?
    @discardableResult func synchronize() -> Bool
}

extension UserDefaults: DefaultsStore {
    func set(data: Data?, for key: DefaultsKey) {
        set(data, forKey: key.rawValue)
    }
    
    func data(for key: DefaultsKey) -> Data? {
        data(forKey: key.rawValue)
    }
}

extension NSUbiquitousKeyValueStore: DefaultsStore {
    func data(for key: DefaultsKey) -> Data? {
        data(forKey: key.rawValue)
    }
    
    func set(data: Data?, for key: DefaultsKey) {
        set(data, forKey: key.rawValue)
    }
}

extension DefaultsStore {
    
    func overwriteAllValues(from: DefaultsStore) {
        DefaultsKey.allCases.forEach {
            overwriteValues(for: $0, from: from)
        }
    }
    
    func overwriteValues(for key: DefaultsKey, from: DefaultsStore) {
        if let data = from.data(for: key) {
            self.set(data: data, for: key)
        }
    }
}

@propertyWrapper
struct UserDefaultable<T: Codable> {
    
    let key: DefaultsKey
    let initial: T
    
    var wrappedValue: T {
        get {
            guard let data = SharedDefaults.data(for: key) else { return initial }
            return (try? JSONDecoder().decode(T.self, from: data)) ?? initial
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            SharedDefaults.set(data: data, for: key)
        }
    }
    
    init(wrappedValue: T, key: DefaultsKey) {
        self.key = key
        self.initial = wrappedValue
    }
}
