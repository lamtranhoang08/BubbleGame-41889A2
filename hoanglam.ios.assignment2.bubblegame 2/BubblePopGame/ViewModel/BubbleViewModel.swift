//
//  BubbleViewModel.swift
//  BubblePopGame
//
//  Created by Lâm Trần on 17/4/24.
//

import SwiftUI

class BubbleViewModel: ObservableObject  {
    @Published var bubbles: [Bubble] = [] // array to store objects of tybe Bubble
    @Published var score: Int = 0   // player score
    @Published var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")  //player high score
    @Published var countBubbles: Int    //the number of bubbles in game
    
    private var gameTimer: Timer?   //timer to control game
    private let bubbleSize = CGSize(width: CGFloat(90), height: CGFloat(90))    //size of the bubbles
    private var lastBubble: Bubble? //the last poped bubble
    let screenSize: CGSize  //Size of the screen
    private var shouldAdd: Bool = false //determine if new bubbles should be added
    
    /**
     initializer
     */
    init(
        score: Int,
        screenSize: CGSize,
        countBubbles: Int) {
            self.score = score
            self.countBubbles = countBubbles
            self.screenSize = screenSize
        }
    /**
     set up the game
     */
    func setUp() {
        guard self.countBubbles > 0 else {return}
        // initBubbles indicates the num of bubbles at first stage
        let initBubbles = Int.random(in: 1...countBubbles)
        for _ in 0...initBubbles {
            addBubble() //add bubble to the game
        }
        //set timer to automatically reload bubbles
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            [weak self] _ in self?.refresh()
        }
    }
    
    /**
     caculate the point base on the color of each poped bubbles
     return an integer representing point of each color
     */
    func getPoint(color: Color) -> Int{
        switch color{
            case .red: return 1
            case .pink: return 2
            case .blue: return 8
            case .green: return 5
            default: return 10
        }
        
    }
    
    /**
     randomly generate color of bubbles
     return Color of bubbles
     */
    func randomBubbleColor() -> Color {
        let random = Int.random(in: 1...100)
        switch random {
            case 1...40: return Color.red
            case 41...70: return Color.pink
            case 71...85: return Color.green
            case 86...95: return Color.blue
            default: return Color.black
        }
    }
    
    /**
     place bubble randomly on screen
     return a CGPoint of the bubble
     */
    func randomPosition() -> CGPoint{
        let radius = bubbleSize.width / 2
        let xRange = radius...(screenSize.width - radius) //ensure the bubbles inside the screen
        let yRange = radius...(screenSize.height - 200) //ensure the bubbles inside the screen
        var point: CGPoint
        repeat {
            let x = CGFloat.random(in: xRange)
            let y = CGFloat.random(in: yRange)
            point = CGPoint(x: x, y: y)
            
        }
        while isOverlap(point)
        return point
    }
    
    /**
     check if new bubbles placed on the same position with existing bubbles
     return a boolean
     */
    func isOverlap(_ point: CGPoint) -> Bool {
        var distance: CGFloat
        for bubble in bubbles {
            distance = sqrt((point.x - bubble.pos.x) * (point.x - bubble.pos.x) + ((point.y - bubble.pos.y) * (point.y - bubble.pos.y)) ) //formula to calculate distance between 2 points in a coordinate
            if distance < bubbleSize.width {
                return true
            }
        }
        return false
    }
    
    /**
     add new bubbles to the game
     */
    func addBubble() {
        guard bubbles.count < countBubbles else {
            return
        }
        let randomColor = randomBubbleColor()
        let position = randomPosition()
        let newBubble = Bubble(color: randomColor, pos: position, point: CGFloat(getPoint(color: randomColor)))
        guard !isOverlap(newBubble.pos) else {return}
        bubbles.append(newBubble)
    }
    
    /**
     handle when user tap on the bubble
     */
    func getBubble(bubble: Bubble) {
        var point = getPoint(color: bubble.color) //get points based on the tapped bubble
        
        // check if the latest bubble is the same color of the previous one
        if let lastPop = lastBubble, bubble.color == lastPop.color {
            point = Int((Double(bubble.point * 1.5)).rounded()) //Increase points for consecutive pops of the same color
        }
        score += point //update player score
        //update highscore if current score passes the highscore
        if(score > highScore) {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "HighScore")
        }
        lastBubble = bubble
        bubbles = bubbles.filter{$0.id != bubble.id}

    }

    /**
     refresh  game state automatically
     */
    func refresh() {
        if shouldAdd{
            guard bubbles.count < countBubbles else {return}
            let newBubbles = Int.random(in: 1...(countBubbles - bubbles.count))
            for _ in 0..<newBubbles {
                addBubble() //add new bubbles
            }
        } else {
            self.bubbles = self.bubbles.filter{
                _ in Bool.random() //randomly remove bubbles
            }
        }
        shouldAdd.toggle()
    }
}
