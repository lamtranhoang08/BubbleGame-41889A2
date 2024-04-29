//
//  SettingsView.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//

import SwiftUI

struct SettingsView: View {
    //handle user inputs and settings value
    @State private var countdownInput = ""
    //game duration. default to 60
    @State private var countdownValue: Double = 60
    //maximum number of bubbles. default to 15
    @State private var numberOfBubbles: Double = 15
    //player's name
    @State private var playerName : String = ""
    var body: some View {
            VStack{
                //design the layout
                Label("Settings",systemImage: "")
                    .foregroundStyle(.green)
                    .font(.title)
            
                Spacer()
                Text("Enter Your Name:")
                
                TextField("Enter Name", text: $playerName)
                    .padding()
                Spacer()
                Text("Game Time")
                Slider(value: $countdownValue, in: 0...60, step: 1)
                    .padding()
                    .onChange(of: countdownValue, perform: { value in
                        countdownInput = "\(Int(value))"
                    })
                Text(" \(Int(countdownValue))")
                    .padding()

                Text("Max Number of Bubbles")
                Slider(value: $numberOfBubbles, in: 0...15, step: 1)
                    .padding()
                                
                Text("\(Int(numberOfBubbles))")
                                    .padding()
                NavigationLink(
                    destination: StartGameView(playerName: playerName, countdownInput: $countdownInput, countdownValue: $countdownValue, score: 0, countBubbles: Int(numberOfBubbles)),
                    label: {
                        Text("Start Game")
                            .font(.title)
                    })
                Spacer()
                
            }
            .padding()
            .onDisappear{
            // Save player's name to UserDefaults when view disappear
                UserDefaults.standard.set(playerName, forKey: "PlayerName")
            }
        }
}

