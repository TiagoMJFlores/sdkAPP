//
//  RewardedDialogConfig.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

public struct RewardedDialogConfig {
    public let message: String
    public let claimLabel: String

    public init(
        message: String = "Watch this to claim your reward",
        claimLabel: String = "Claim Reward"
    ) {
        self.message = message
        self.claimLabel = claimLabel
    }

    public static let `default` = RewardedDialogConfig()
}
