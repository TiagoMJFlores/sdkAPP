//
//  ConsentView.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import SwiftUI

public extension View {
    func consentHost(_ manager: ConsentManager) -> some View {
        modifier(ConsentHostModifier(manager: manager))
    }
}

internal struct ConsentHostModifier: ViewModifier {
    @ObservedObject var manager: ConsentManager

    func body(content: Content) -> some View {
        content.alert(manager.config.title, isPresented: $manager.isDialogVisible) {
            Button(manager.config.acceptLabel) { manager.handleDecision(true) }
            Button(manager.config.declineLabel, role: .cancel) { manager.handleDecision(false) }
        } message: {
            Text(manager.config.message)
        }
    }
    
}
