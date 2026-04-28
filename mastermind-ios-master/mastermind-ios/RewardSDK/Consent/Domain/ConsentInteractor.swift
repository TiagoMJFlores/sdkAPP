//
//  ConsentInteractor.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

internal protocol ConsentInteractorProtocol {
    func currentStatus() -> Bool?
    func recordDecision(_ granted: Bool)
    func shouldRequestConsent() -> Bool
}

internal struct ConsentInteractor {
    private let storage: ConsentStorage

    init(storage: ConsentStorage) {
        self.storage = storage
    }
}

extension ConsentInteractor: ConsentInteractorProtocol {
    
    func currentStatus() -> Bool? {
        storage.loadConsent()
    }

    func recordDecision(_ granted: Bool) {
        storage.saveConsent(granted)
    }

    func shouldRequestConsent() -> Bool {
        currentStatus() == nil
    }
}
