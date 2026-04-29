//
//  SentrySink.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

internal final class SentrySink: LogSink {
    
    func write(_ message: String, level: LogLevel) {
        guard level == .error || level == .warning else { return }
        // add consent manager in future?
        // SentrySDK.capture(message: message) { scope in
        //     scope.setLevel(level == .error ? .error : .info)
        //     scope.setTag(value: "rewardsdk", key: "module")
        //or use an endpoint to avoid integrate sentry inside the sdk }
    }
}
