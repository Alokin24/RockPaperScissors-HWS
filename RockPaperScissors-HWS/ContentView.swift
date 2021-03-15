//
//  ContentView.swift
//  RockPaperScissors-HWS
//
//  Created by Nikola Anastasovski on 15.3.21.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    
    let winningCombinations: [String: String] = [
        "Rock": "Scissors",
        "Scissors": "Paper",
        "Paper": "Rock"
    ]
    
    @State private var computerMoveId = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var roundResult = ""
    @State private var roundsPassed = 0
    
    var roundObjective: String {
        shouldWin ? "Win": "Don't win"
    }
    
    var computerMove: String {
        moves[computerMoveId]
    }
    
    
    func playerWinsRound(playerMove: String, computerMove: String) -> Bool {
        winningCombinations[playerMove] == computerMove
    }
    
    func nextRound() {
        computerMoveId = Int.random(in: 0...2)
        shouldWin = Bool.random()
        roundsPassed += 1
    }
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white, Color.gray]), startPoint: .top, endPoint: .bottom)
                
                
                if roundsPassed != 10 {
                    VStack(spacing: 75) {
                        
                        VStack {
                            Text("Player score: \(playerScore)")
                                .font(.title2)
                                .fontWeight(.heavy)
                            Text(roundResult)
                                .fontWeight(.heavy)
                        }
                        
                        VStack(spacing: 10) {
                            
                            Text("Computer chose:")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Button(action: {
                                
                            }) {
                                ToolView(imageName: moves[computerMoveId])
                            }
                        }
                        
                        Text("\(roundObjective) the round.")
                            .font(.title2)
                            .foregroundColor(shouldWin ? .green: .red)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 10) {
                            
                            Text("Your choice:")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            HStack(spacing: 35) {
                                
                                ForEach(moves, id: \.self) { move in
                                    Button(action: {
                                        let playerWon = self.playerWinsRound(playerMove: move, computerMove: computerMove)
                                        
                                        if (playerWon && shouldWin) || (!playerWon && !shouldWin) {
                                            playerScore += 1
                                            roundResult = "You won the last round."
                                        } else {
                                            roundResult = "You lost the last round."
                                        }
                                        
                                        nextRound()
                                    }) {
                                        ToolView(imageName: move)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    VStack(spacing: 10) {
                        
                        Text("Game Over.")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text("Your score: \(playerScore)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(playerScore >= 5 ? Color.green: Color.red)
                    }
                }
            }
            .navigationBarTitle("Rock Paper Scissors")
            .navigationBarTitleDisplayMode(.large)
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

struct ChoiceModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title3)
    }
}

extension ViewModifier {
    func choiceModifier(content: Text) -> some View {
        content
            .modifier(ChoiceModifier())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
