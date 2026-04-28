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
    private let logger: RewardSDKLoggerProtocol
    
    internal init(interactor: ConsentInteractorProtocol, config: ConsentDialogConfig, logger: RewardSDKLoggerProtocol) {
        self.interactor = interactor
        self.config = config
        self.logger = logger
    }

    public func showConsentDialog() {
        logger.log("showConsentDialog called", level: .info)
        guard interactor.shouldRequestConsent() else { return }
        isDialogVisible = true
        logger.log("Consent dialog presented to user", level: .info)
    }

    public func getConsentStatus() -> Bool? {
        interactor.currentStatus()
    }

    internal func handleDecision(_ granted: Bool) {
        interactor.recordDecision(granted)
        isDialogVisible = false
        logger.log("Consent decision recorded: granted=\(granted)", level: .info)
    }
}
