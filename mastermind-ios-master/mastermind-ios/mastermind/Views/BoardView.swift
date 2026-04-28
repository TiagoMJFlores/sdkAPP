//
//  BoardView.swift
//  Mastermind
//
//  Copyright © 2022 Miniclip. All rights reserved.
//

import SwiftUI

struct BoardView: View {
    private var codePegViews = [
        CodePegView(),
        CodePegView(),
        CodePegView(),
        CodePegView(),
        CodePegView(),
        CodePegView(),
        CodePegView(),
        CodePegView()
    ]
    
    init() {
        enableLine(line: 7, value: true)
    }
    
    var body: some View {
        VStack {
            ForEach(codePegViews.indices, id: \.self) { index in
                codePegViews[index]
            }
        }
    }
    
    func enableLine(line: Int, value: Bool) {
        codePegViews[line].enablePeg(value: value)
    }
    
    func getLineColors(line: Int) -> [Color] {
        let pegColors: [Color] = codePegViews[line].getPegColors()
        
        return pegColors
    }
    
    func setColorResult(line: Int, value: String, description: String) {
        codePegViews[line].setColorResultLabel(value: value, description: description)
    }
    
    func setLocationResult(line: Int, value: String, description: String) {
        codePegViews[line].setLocationResultLabel(value: value, description: description)
    }
    
    func cleanLine(line: Int) {
        codePegViews[line].cleanPegButtons()
    }
    
    func cleanBoard() {
        for codePegView in codePegViews {
            codePegView.cleanPegButtons()
            codePegView.enablePeg(value: false)
        }
        
        codePegViews[7].enablePeg(value: true)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
