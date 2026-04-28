//
//  ConsentInteractorTests.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Testing
import Foundation
@testable import RewardSDK

@Suite struct ConsentInteractorTests {

    private final class StorageSpy: ConsentStorage {
        var stored: Bool?
        func loadConsent() -> Bool? { stored }
        func saveConsent(_ value: Bool) { stored = value }
    }

    private static func makeSUT(stored: Bool? = nil) -> (sut: ConsentInteractor, storage: StorageSpy) {
        let storage = StorageSpy()
        storage.stored = stored
        return (ConsentInteractor(storage: storage), storage)
    }

    @Test func recordDecision_persistsToStorage() {
        let (sut, storage) = Self.makeSUT()
        sut.recordDecision(true)
        #expect(storage.stored == true)
    }

    @Test func currentStatus_returnsStoredValue() {
        let (sut, _) = Self.makeSUT(stored: true)
        #expect(sut.currentStatus() == true)
    }

    @Test func shouldRequestConsent_isTrue_whenNoDecisionStored() {
        let (sut, _) = Self.makeSUT(stored: nil)
        #expect(sut.shouldRequestConsent() == true)
    }

    @Test func shouldRequestConsent_isFalse_whenConsentAccepted() {
        let (sut, _) = Self.makeSUT(stored: true)
        #expect(sut.shouldRequestConsent() == false)
    }

    @Test func shouldRequestConsent_isFalse_whenConsentRejected() {
        let (sut, _) = Self.makeSUT(stored: false)
        #expect(sut.shouldRequestConsent() == false)
    }

    @Test func recordDecision_changesShouldRequestConsentToFalse() {
        let (sut, _) = Self.makeSUT(stored: nil)
        #expect(sut.shouldRequestConsent() == true)

        sut.recordDecision(true)

        #expect(sut.shouldRequestConsent() == false)
    }
}
