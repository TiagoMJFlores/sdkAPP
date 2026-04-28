//
//  Secret.swift
//  Mastermind
//
//  Copyright © 2022 Miniclip. All rights reserved.
//

import SwiftUI

class Secret: ObservableObject {
    
    @Published var backgroundColor: Color
    @Published var secretText: String
    
    init() {
        self.backgroundColor = Color.wildBlueYonder
        self.secretText = "?"
    }
}
