//
//  SentrySink.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

internal final class SentrySink: LogSink {
    func write(_ message: String, level: LogLevel) {
        // SentrySDK.capture(message: message) { scope in
        //     scope.setLevel(level == .error ? .error : .info)
        //     scope.setTag(value: "rewardsdk", key: "module")
        // }
    }
}
