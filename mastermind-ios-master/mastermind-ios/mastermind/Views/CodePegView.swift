//
//  CodePegView.swift
//  Mastermind
//
//  Copyright © 2022 Miniclip. All rights reserved.
//

import SwiftUI

struct CodePegView: View {
    private var colorResultLabel = ResultLabel()
    private var locationResultLabel = ResultLabel()
    private var codePegButtons = [
        CodePegButton(),
        CodePegButton(),
        CodePegButton(),
        CodePegButton()
    ]
    
    var body: some View {
        HStack {
            colorResultLabel
            ForEach(codePegButtons.indices, id: \.self) { index in
                codePegButtons[index]
            }
            locationResultLabel
        }
    }
    
    func enablePeg(value: Bool) {
        for codePegButton in codePegButtons {
            codePegButton.peg.disabled = !value
        }
    }
    
    func getPegColors() -> [Color] {
        var pegColors: [Color] = []
        
        for codePegButton in codePegButtons {
            pegColors.append(codePegButton.peg.backgroundColor)
        }
        
        return pegColors
    }
    
    func setColorResultLabel(value: String, description: String) {
        colorResultLabel.result.value = value
        colorResultLabel.result.description = description
    }
    
    func setLocationResultLabel(value: String, description: String) {
        locationResultLabel.result.value = value
        locationResultLabel.result.description = description
    }
    
    func cleanPegButtons() {
        colorResultLabel.result.value = ""
        colorResultLabel.result.description = ""
        locationResultLabel.result.value = ""
        locationResultLabel.result.description = ""
        
        for codePegButton in codePegButtons {
            codePegButton.peg.backgroundColor = Color.aliceBlue
        }
    }
}

struct CodePegButton: View {
    @State private var colorIndex = 0
    @ObservedObject var peg = Peg()
    
    var body: some View {
        Button(action: { self.setButtonColor() }) {
            Text("")
                .padding()
        }
        .frame(width: 50, height: 50)
        .background( peg.backgroundColor )
        .clipShape(Circle())
        .disabled(peg.disabled)
    }
    
    func setButtonColor() {
        if (colorIndex < PegColors.colors.count) {
            peg.backgroundColor = PegColors.colors[colorIndex]
            colorIndex += 1
        } else {
            peg.backgroundColor =  PegColors.colors[0]
            colorIndex = 1
        }
    }
}

struct ResultLabel: View {
    @ObservedObject var result = Result()
    
    var body: some View {
        VStack(alignment: .center) {
            Text(result.value)
                .multilineTextAlignment(.center)
                .font(.callout)
            
            Text(result.description)
                .multilineTextAlignment(.center)
                .font(.system(size: 8))
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 30, height: 15)
        .foregroundColor(Color.mediumSlateBlue)
    }
}

struct CodePegView_Previews: PreviewProvider {
    static var previews: some View {
        CodePegView()
    }
}
