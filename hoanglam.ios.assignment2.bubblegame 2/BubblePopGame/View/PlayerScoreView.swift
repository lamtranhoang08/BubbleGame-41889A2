//
//  PlayerScoreView.swift
//  BubblePopGame
//
//  Created by Lâm Trần on 13/4/24.
//

import SwiftUI

struct PlayerScoreView: View {
    var playerScore: PlayerScore
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
            Text(playerScore.playerName)
            Text("\(playerScore.score)")
        
        }
        .padding()
    }
}
