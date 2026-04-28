//
//  Mastermind.swift
//  Mastermind
//
//  Copyright © 2022 Miniclip. All rights reserved.
//

import SwiftUI
import RewardSDK

@main
struct Mastermind: App {
        
    @StateObject private var consentManager = makeConsentManager()

    var body: some Scene {
        WindowGroup {
            ContentView(consentManager: consentManager)
        }
    }
}
