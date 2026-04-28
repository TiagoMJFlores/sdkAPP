//
//  RewardSDK.swift
//  RewardSDK
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

import Foundation

public func makeConsentManager() -> ConsentManager {
    ConsentManager(interactor: ConsentInteractor(storage: UserDefaultsConsentStorage()), config: .default)
}

public func makeRewardedManager() -> RewardedManager {
    RewardedManager(config: .default)
}
