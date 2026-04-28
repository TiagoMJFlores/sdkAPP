//
//  ConsentManagerProtocol.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

public protocol ConsentManagerProtocol: AnyObject {
    func showConsentDialog()
    func getConsentStatus() -> Bool?
}
