//
//  SecretPegView.swift
//  Mastermind
//
//  Copyright © 2022 Miniclip. All rights reserved.
//

import SwiftUI

struct SecretPegView: View {
    private var secretsPegsButton = [
        SecretPegButton(),
        SecretPegButton(),
        SecretPegButton(),
        SecretPegButton()
    ]
    
    var body: some View {
        HStack{            
            ForEach(secretsPegsButton.indices, id: \.self) { index in
                secretsPegsButton[index]
            }
        }
    }
    
    func showSecret(secret: [Color]) {
        for (index, secretPegButton) in secretsPegsButton.enumerated() {
            secretPegButton.secret.secretText = ""
            secretPegButton.secret.backgroundColor = secret[index]
        }
    }
    
    func hideSecret() {
        for secretPegButton in secretsPegsButton {
            secretPegButton.secret.secretText = "?"
            secretPegButton.secret.backgroundColor = Color.wildBlueYonder
        }
    }
}

struct SecretPegButton: View {
    @ObservedObject var secret = Secret()
    
    var body: some View {
        Button(action: {}) {
            Text(secret.secretText)
                .foregroundColor(Color.white)
                .bold()
        }
        .frame(width: 50, height: 50)
        .background(secret.backgroundColor)
        .clipShape(Circle())
    }
}

struct SecretPegView_Previews: PreviewProvider {
    static var previews: some View {
        SecretPegView()
    }
}
