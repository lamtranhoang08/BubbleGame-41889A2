//
//  ContentView.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//

import SwiftUI

struct ContentView: View {
    var playerName: String = ""
    var score: Int = 0
    
    var body: some View {
        // NavigationView to provide navigation functionality
        NavigationView {
            VStack {
                //Title of the game
                Label("Bubble Pop", systemImage: "")
                    .foregroundStyle(Color.mint)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                //represent the game icon
                Image("icon")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                
                Spacer()
                            
                //navigate the settings view
                NavigationLink(
                    destination: SettingsView(),
                    label: {
                        Text("New Game")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.blue)
                                    .shadow(radius: 5)
                            )
                    }
                )
                .padding()
                
                //navigate the HighScoreView
                NavigationLink(
                    destination: HighScoreView(),
                    label: {
                        Text("High Score")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.orange)
                                    .shadow(radius: 5)
                            )
                    }
                )
                Spacer()
            }
            .padding()
            .navigationTitle("")
            .navigationBarHidden(true) // Hide navigation bar title
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
