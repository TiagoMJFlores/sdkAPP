//
//  RewardedView.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//
import SwiftUI


internal struct RewardedView: View {
    let config: RewardedDialogConfig
    let onClaim: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text(config.message)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button(action: onClaim) {
                Text(config.claimLabel)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

public extension View {
    func rewardedHost(_ manager: RewardedManager) -> some View {
        modifier(RewardedHostModifier(manager: manager))
    }
}

internal struct RewardedHostModifier: ViewModifier {
    @ObservedObject var manager: RewardedManager

    func body(content: Content) -> some View {
        content.sheet(isPresented: $manager.isPresented) {
            RewardedView(config: manager.config, onClaim: { manager.handleClaim() })
        }
    }
}

