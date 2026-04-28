//
//  ConsentManager.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Combine

public final class ConsentManager: ObservableObject, ConsentManagerProtocol {
    @Published internal var isDialogVisible: Bool = false

    private let interactor: ConsentInteractorProtocol
    internal let config: ConsentDialogConfig
    
    internal init(interactor: ConsentInteractorProtocol, config: ConsentDialogConfig) {
        self.interactor = interactor
        self.config = config
    }

    public func showConsentDialog() {
        guard interactor.shouldRequestConsent() else { return }
        isDialogVisible = true
    }

    public func getConsentStatus() -> Bool? {
        interactor.currentStatus()
    }

    internal func handleDecision(_ granted: Bool) {
        interactor.recordDecision(granted)
        isDialogVisible = false
    }
}
