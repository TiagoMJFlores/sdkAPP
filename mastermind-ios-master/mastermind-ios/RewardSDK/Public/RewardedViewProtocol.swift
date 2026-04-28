//
//  RewardedViewProtocol.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

public protocol RewardedViewProtocol: AnyObject {
    func showRewardedView()
    var onClaimReward: (() -> Void)? { get set }
}
