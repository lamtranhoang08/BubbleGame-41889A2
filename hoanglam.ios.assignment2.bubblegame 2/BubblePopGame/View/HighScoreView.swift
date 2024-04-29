import SwiftUI

struct HighScoreView: View {
    @StateObject var viewModel = HighScoreViewModel()
    var playerName: String?
    var score: Int?
    
    var body: some View {
        VStack {
            Text("High Score")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding(.top, 20)
            
            Spacer()
            
            //list to show high score record
            List(viewModel.playerScores.sorted(by: {$0.score > $1.score}).prefix(7)) { playerScore in
                HStack {
                    Text("\(playerScore.playerName)")
                        .foregroundColor(.blue)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(playerScore.score)")
                        .foregroundColor(.green)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 8)
            }
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        .padding()
        .onAppear {
            if let playerName = playerName, let score = score, score >= 0 {
                if playerName == "" {
                    viewModel.savePlayerScore(playerName: "Unknown Player", score: score)
                } else {
                    viewModel.savePlayerScore(playerName: playerName, score: score)
                }
            }
        }
    }
}
