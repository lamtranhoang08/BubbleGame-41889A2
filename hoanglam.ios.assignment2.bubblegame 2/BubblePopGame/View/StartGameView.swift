//
//  StartGameView.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//

import SwiftUI

struct StartGameView: View {
    @StateObject var viewModel: BubbleViewModel
    @ObservedObject var highScoreVM: HighScoreViewModel
    @Binding var countdownInput: String
    @Binding var countdownValue: Double
    @State private var score : Int = 0;
    @State var navigationPath = NavigationPath()
    @State private var isGameFinished : Bool = false
    var playerName : String
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //constructor
    init(playerName: String, countdownInput: Binding<String>, countdownValue: Binding<Double>, score: Int, countBubbles: Int) {
        self.playerName = playerName
        self._countdownInput = countdownInput
        self._countdownValue = countdownValue
        _viewModel = StateObject(wrappedValue: BubbleViewModel(score: score,  screenSize: UIScreen.main.bounds.size, countBubbles: Int(countBubbles)))
        self._highScoreVM = ObservedObject(wrappedValue: HighScoreViewModel())
    }
    var body: some View {
        NavigationStack(path: $navigationPath){
            VStack{
                //display time, score, highscore
                HStack {
                    VStack{
                        Text("Time Left")
                        Text("\(Int(countdownValue))")
                        
                    }
                    Spacer();
                    VStack {
                        Text("Score")
                        Text("\(viewModel.score)")
                    }
                    Spacer();
                    VStack{
                        Text("High score")
                        Text("\(Int(viewModel.highScore))")
                    }
                }
                .padding()
                //show bubbles
                ZStack {
                    ForEach(viewModel.bubbles)
                    {bubble in Circle()
                            .fill(bubble.color).onTapGesture{ viewModel.getBubble(bubble: bubble)}
                            .frame(width: 80, height: 80)
                            .position(bubble.pos)
                    }
                    .animation(.easeOut, value: viewModel.bubbles)
                    .transition(.scale)
                }
                .frame(width: viewModel.screenSize.width, height: viewModel.screenSize.height - 250)
                .background(Color.white)
                .onAppear{viewModel.setUp()}
                Spacer()
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 80)
            //ignore safe area insets for top edge
            .edgesIgnoringSafeArea(.top)
            //navigation destination for player score
            .navigationDestination(for: PlayerScore.self) {
                playerScore in HighScoreView(playerName: playerScore.playerName, score: playerScore.score)
                    .navigationBarBackButtonHidden(true)
            }
            //receive timer update
            .onReceive(timer, perform: { _ in
                if countdownValue > 0 && !isGameFinished {
                    countdownValue -= 1;
                    countdownInput = "\(countdownValue)"
                }
                else {
                    self.endGame()
                }
            })
            //handle interupting case
            .onDisappear() {
                guard !isGameFinished else {return}
                self.timer.upstream.connect().cancel()
                isGameFinished = true //set flag to true
                if playerName != "" {
                    highScoreVM.savePlayerScore(playerName: playerName, score: viewModel.score)
                } else {
                    highScoreVM.savePlayerScore(playerName: "Unknown Player", score: viewModel.score)
                }
            }
            
        }
    }
    
    /**
     terminate the game
     */
    private func endGame() {
        isGameFinished = true //set flag to true
        self.timer.upstream.connect().cancel()
        //create object to store name & score
        let playerScore = PlayerScore(playerName: playerName, score: viewModel.score)
        navigationPath.append(playerScore)
        //append score to navigation path
    }
}

