//
//  ConsentDialogConfig.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation


public struct ConsentDialogConfig {
    public let title: String
    public let message: String
    public let acceptLabel: String
    public let declineLabel: String

    public init(
        title: String = "Privacy",
        message: String = "Do you consent to data collection to personalise your experience?",
        acceptLabel: String = "Consent",
        declineLabel: String = "Do Not Consent"
    ) {
        self.title = title
        self.message = message
        self.acceptLabel = acceptLabel
        self.declineLabel = declineLabel
    }

    public static let `default` = ConsentDialogConfig()
}
