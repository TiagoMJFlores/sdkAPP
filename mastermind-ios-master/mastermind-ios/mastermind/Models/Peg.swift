//
//  Peg.swift
//  Mastermind
//
//  Copyright © 2022 Miniclip. All rights reserved.
//

import SwiftUI

class Peg: ObservableObject {
    
    @Published var backgroundColor: Color
    @Published var disabled: Bool
    
    init() {
        self.backgroundColor = Color.aliceBlue
        self.disabled = true
    }
}
