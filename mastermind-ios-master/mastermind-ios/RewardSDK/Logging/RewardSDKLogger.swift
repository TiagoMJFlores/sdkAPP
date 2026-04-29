//
//  RewardSDKLogger.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

protocol RewardSDKLoggerProtocol {
    func log(_ message: String, level: LogLevel)
}

internal final class RewardSDKLogger {
    private let sinks: [LogSink]

    init(sinks: [LogSink]) {
        self.sinks = sinks
    }

}

extension RewardSDKLogger: RewardSDKLoggerProtocol {
    func log(_ message: String, level: LogLevel) {
        sinks.forEach { $0.write(message, level: level) }
    }
}

internal func makeDefaultLogger() -> RewardSDKLogger {
    RewardSDKLogger(sinks: [
        OSLogSink(),
        SentrySink()
    ])
}
