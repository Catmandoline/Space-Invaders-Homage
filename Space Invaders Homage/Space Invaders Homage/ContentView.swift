//
//  ContentView.swift
//  Space Invaders Homage
//
//  Created by Michel Matys on 05.08.24.
//

import SwiftUI
import SpriteKit
import GameKit

enum GameState {
    case contentview
    case gameplay
    case gameover
    case highscore
}

struct ContentView: View {
    @State private var currentGameState: GameState = .contentview
    @State private var showGameScene = false
    @State private var showCountdown = false
    @State private var countdownFinished = false
    @State private var playerName = ""
    @State private var playersMaxScore = 0
    @State public var playerLives = 3
    @State public var playerScore = 0
    
    var body: some View {
            ZStack {
                Image("background-contenview")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)

                if showCountdown {
                    CountdownOverlay(countdownFinished: $countdownFinished, showCountDown: $showCountdown, showGameScene: $showGameScene)
                }

                switch currentGameState {
                case .contentview:
                    VStack {
                        Spacer()

                        Button("Spiel Starten") {
                            showCountdown = true
                        }
                        .padding()
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 150)
                    }
                
            case .gameplay:
                if countdownFinished {
                    GameplayView(showGameScene: $showGameScene, countdownFinished: $countdownFinished, playerScore: $playerScore, playerLives: $playerLives)
                }
                
            case .gameover:
                GameOverView()
                
            case .highscore:
                HighScoreView()
            }
        }
        .onChange(of: countdownFinished) {
            if countdownFinished {
                currentGameState = .gameplay
            }
        }
    }
}

struct CountdownOverlay: View {
    @Binding var countdownFinished: Bool
    @Binding var showCountDown: Bool
    @Binding var showGameScene: Bool
    @State private var countdown = 3
    
    var body: some View {
        if countdown > 0 {
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                Text("\(countdown)")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            if countdown > 1 {
                                countdown -= 1
                            } else {
                                timer.invalidate()
                                countdownFinished = true
                                showCountDown = false
                                showGameScene = true
                            }
                        }
                    }
            }
            .edgesIgnoringSafeArea(.all) // Ignoriere Safe Area, um das Overlay auf den gesamten Bildschirm auszudehnen
        }
    }
}

#Preview {
    ContentView()
}
