//
//  OSLogSink.swift
//  mastermind-test
//
//  Created by Tiago Flores on 29/04/2026.
//

import Foundation
import os

internal final class OSLogSink: LogSink {
    private let logger: Logger

    init(subsystem: String = "com.miniclip.rewardsdk", category: String = "general") {
        self.logger = Logger(subsystem: subsystem, category: category)
    }

    func write(_ message: String, level: LogLevel) {
        switch level {
        case .debug:   logger.debug("\(message, privacy: .public)")
        case .info:    logger.info("\(message, privacy: .public)")
        case .warning: logger.warning("\(message, privacy: .public)")
        case .error:   logger.error("\(message, privacy: .public)")
        }
    }
}
