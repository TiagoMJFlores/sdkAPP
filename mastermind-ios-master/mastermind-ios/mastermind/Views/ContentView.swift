//
//  ContentView.swift
//  Mastermind
//
//  Copyright © 2022 Miniclip. All rights reserved.
//

import SwiftUI
import RewardSDK

struct ContentView: View {
    private var secretPegView = SecretPegView()
    private var boardView = BoardView()
    
    private var hintMessage: String {
        guard let color = hintColor else { return "No hint available yet." }
        return "One of the secret colors is \(name(for: color))."
    }

    
    private func name(for color: Color) -> String {
        switch color {
        case .blue: return "blue"
        case .pink: return "pink"
        case .green: return "green"
        case .yellow: return "yellow"
        case .red: return "red"
        case .orange: return "orange"
        default: return "unknown"
        }
    }
    
    @ObservedObject var consentManager: ConsentManager
    @StateObject private var rewardedManager = makeRewardedManager()


    @State private var round: Int = 7;
    @State private var secretColors: [Color] = []
    @State private var alertFillColorsIsVisible: Bool = false
    @State private var alertWinIsVisible: Bool = false
    @State private var hintColor: Color?
    @State private var hintAlertVisible: Bool = false
    @State private var alertOverIsVisible: Bool = false
    @State private var showAd: Bool = false
    
    private var gameInProgress: Bool {
        !secretColors.isEmpty && round > 0
    }
    
    init(consentManager: ConsentManager) {
            self.consentManager = consentManager
        }
    
    var body: some View {
        VStack {
            secretPegView
            boardView
            if gameInProgress {
                Button("Hint") {
                    rewardedManager.showRewardedView()
                }
                .buttonStyle(.bordered)
                .padding(.bottom, 4)
            }
            
            TabBarView(restart: restart, submitLine: submitLine, clearLine: clearLine)
        }
        .alert("Oh, no!", isPresented: $alertFillColorsIsVisible) {
          Button("OK") { }
        } message: {
          Text("Please, fill all pegs.")
        }
        .alert("😀", isPresented: $alertWinIsVisible) {
          Button("OK") {
              self.restart()
          }
        } message: {
          Text("You win!")
        }
        .alert("☹️", isPresented: $alertOverIsVisible) {
          Button("OK") {
              self.restart()
          }
        } message: {
          Text("You loose! Let's play again!")
        }
        .alert("Hint", isPresented: $hintAlertVisible) {
            Button("OK") { }
        } message: {
            Text(hintMessage)
        }
        .rewardedHost(rewardedManager)
        .consentHost(consentManager)
        .onAppear {
            rewardedManager.onClaimReward = {
                hintColor = secretColors.randomElement()
                hintAlertVisible = true
            }
            if consentManager.getConsentStatus() == nil {
                consentManager.showConsentDialog()
            }
        }

    }
    
    func restart() {
        round = 7
        hintColor = nil
        secretPegView.hideSecret()
        boardView.cleanBoard()
    }
    
    func submitLine() {
        if (round == 7) {
            setSecret()
        }
        
        if (round == 0) {
            self.alertOverIsVisible.toggle()
            secretPegView.showSecret(secret: secretColors)
            return
        }
        
        let pegColors: [Color] = boardView.getLineColors(line: round)
        
        if (!lineIsFilled(pegColors: pegColors)) {
            self.alertFillColorsIsVisible.toggle()
            return
        }
        
        if (pegColors.elementsEqual(secretColors)) {
            self.alertWinIsVisible.toggle()
            secretPegView.showSecret(secret: secretColors)
        } else {
            let matchedColor  = Set(pegColors).intersection(secretColors).count
            boardView.setColorResult(line: round, value: String(matchedColor), description: "Colors Right")
            
            let matchedLocations = zip(pegColors, secretColors).filter(==).map{ $1 }.count
            boardView.setLocationResult(line: round, value: String(matchedLocations), description: "Places Right")
        }
        
        #if DEBUG
        print("Selected Colors: " + pegColors.description)
        print("Secret Colors: " + secretColors.description)
        #endif
        
        round -= 1
        boardView.enableLine(line: round, value: true)
    }
    
    func clearLine() {
        if (round >= 0) {
            boardView.cleanLine(line: round)
        }
    }
    
    func lineIsFilled(pegColors: [Color]) -> Bool {
        for pegColor in pegColors {
            if (pegColor == Color.aliceBlue) {
                return false
            }
        }
        
        return true
    }
    
    private func setSecret() {
        var colors: [Color] = PegColors.colors
        secretColors.removeAll()
        
        for _ in 1...4 {
            let color = colors.randomElement()
            secretColors.append(color!)
            colors = colors.filter(){$0 != color}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(consentManager: makeConsentManager())
    }
}
