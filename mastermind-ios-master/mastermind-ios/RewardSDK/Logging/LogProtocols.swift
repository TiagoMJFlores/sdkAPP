//
//  LogLevel.swift
//  mastermind-test
//
//  Created by Tiago Flores on 28/04/2026.
//

import Foundation

internal enum LogLevel {
    case debug, info, warning, error
}

internal protocol LogSink {
    func write(_ message: String, level: LogLevel)
}

