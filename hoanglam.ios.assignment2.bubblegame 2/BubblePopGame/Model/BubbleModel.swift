//
//  BubbleModel.swift
//  BubblePopGame
//
//  Created by Lâm Trần on 17/4/24.
//

import Foundation
import SwiftUI
struct Bubble: Identifiable, Equatable {
    var id = UUID()     //  id of the bubbles
    var color: Color    // the color of the bubbles
    var pos: CGPoint    // the position of the bubble in 2D cooridnate
    var point: CGFloat  // the point value associated with the bubble
    
    
}
