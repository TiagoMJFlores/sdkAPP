//
//  TabBarView.swift
//  Mastermind
//
//  Copyright © 2022 Miniclip. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    var restart: () -> Void
    var submitLine: () -> Void
    var clearLine: () -> Void
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 300, height: 60)
                    .foregroundColor(Color.aliceBlue)
                HStack {
                    TabBarButton(title: "Restart", systemIcon: "memories", action: restart )
                    TabBarButton(title: "Submit Line", systemIcon: "hand.thumbsup.fill", action: submitLine)
                    TabBarButton(title: "Clear Line", systemIcon: "trash.fill", action: clearLine)
                }
            }
        }
    }
}

struct TabBarButton: View {
    var title: String
    var systemIcon: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .center, spacing: 5.0) {
                Image(systemName: systemIcon)
                Text(title)
                    .multilineTextAlignment(.center)
                    .lineSpacing(10)
                    .font(.caption)
            }
            .foregroundColor(Color.mediumSlateBlue)
            .padding()
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(restart: {}, submitLine: {}, clearLine: {})
    }
}
