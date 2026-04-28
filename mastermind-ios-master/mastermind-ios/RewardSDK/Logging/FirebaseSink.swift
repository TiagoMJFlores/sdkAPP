//
//  FirebaseSink.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

internal final class FirebaseSink: LogSink {
    func write(_ message: String, level: LogLevel) {
        // Analytics.logEvent("reward_sdk_event", parameters: [
        //     "level": String(describing: level),
        //     "message": message
        // ])
    }
}
