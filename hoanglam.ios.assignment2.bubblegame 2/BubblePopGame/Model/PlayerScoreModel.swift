//
//  PlayerScoreModel.swift
//  BubblePopGame
//
//  Created by Lâm Trần on 11/4/24.
//

import Foundation
struct PlayerScore: Identifiable, Codable, Hashable{
    var id = UUID()         // player id 
    var playerName: String  // player Name
    var score: Int          // player Score
}
