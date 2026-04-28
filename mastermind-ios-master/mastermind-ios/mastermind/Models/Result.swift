//
//  Result.swift
//  Mastermind
//
//  Copyright © 2022 Miniclip. All rights reserved.
//

import SwiftUI

class Result: ObservableObject {
    
    @Published var value: String
    @Published var description: String
    
    init() {
        self.value = ""
        self.description = ""
    }
}
