//
//  RewardedManager.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Combine

public final class RewardedManager: ObservableObject {
    @Published internal var isPresented: Bool = false
    public var onClaimReward: (() -> Void)?

    internal let config: RewardedDialogConfig

    internal init(config: RewardedDialogConfig) {
        self.config = config
    }
}

extension RewardedManager: RewardedViewProtocol {

    public func showRewardedView() {
        isPresented = true
    }

    internal func handleClaim() {
        let callback = onClaimReward
        isPresented = false
        callback?()
    }
}
