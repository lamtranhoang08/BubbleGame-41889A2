//
//  HighScoreViewModel.swift
//  BubblePopGame
//
//  Created by Lâm Trần on 23/4/24.
//

import Foundation

class HighScoreViewModel: ObservableObject {
    @Published var playerScores: [PlayerScore] = []

    init() {
        loadPlayerScores()
    }

    /**
     load player scores from UserDefaults
     */
    private func loadPlayerScores() {
        if let data = UserDefaults.standard.data(forKey: "PlayerScores") {
            let decoder = JSONDecoder()
            if let decodedPlayerScores = try? decoder.decode([PlayerScore].self, from: data) {
                playerScores = decodedPlayerScores
            }
        }
    }

    /**
     save player score to UserDefault
     */
    func savePlayerScore(playerName: String, score: Int) {
        let newPlayerScore = PlayerScore(playerName: playerName, score: score)
        playerScores.append(newPlayerScore)

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(playerScores) {
            UserDefaults.standard.set(encoded, forKey: "PlayerScores")
        }
    }
}
