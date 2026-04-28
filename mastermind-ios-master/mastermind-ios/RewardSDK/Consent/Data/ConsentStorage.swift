//
//  ConsentStorage.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

internal protocol ConsentStorage {
    func loadConsent() -> Bool?
    func saveConsent(_ value: Bool)
}

internal final class UserDefaultsConsentStorage: ConsentStorage {
    private let defaults: UserDefaults
    private let key: String

    init(defaults: UserDefaults = .standard,
         key: String = "com.miniclip.consent") {
        self.defaults = defaults
        self.key = key
    }

    func loadConsent() -> Bool? {
        guard defaults.object(forKey: key) != nil else { return nil }
        return defaults.bool(forKey: key)
    }

    func saveConsent(_ value: Bool) {
        defaults.set(value, forKey: key)
    }
}
