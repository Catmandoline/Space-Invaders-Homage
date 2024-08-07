//
//  GameplayView.swift
//  Space Invaders Homage
//
//  Created by René Schwarz on 07.08.24.
//

import SwiftUI
import SpriteKit

struct GameplayView: View {
    @Binding var showGameScene: Bool
    @Binding var countdownFinished: Bool
    @Binding var playerScore: Int
    @Binding var playerLives: Int

    var body: some View {
        if showGameScene && countdownFinished {
            SpriteView(scene: GameScene(size: CGSize(width: 400, height: 800), playerScore: $playerScore, playerLives: $playerLives))
                .ignoresSafeArea()
            
            VStack {
                VStack{
                    HStack {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: 120, maxHeight: 30)
                                .foregroundColor(.brown)
                                .opacity(0.8)
                            Text("HighScore: \(playerLives)")
                                .foregroundColor(.white)
                        }
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: 120, maxHeight: 30)
                                .foregroundColor(.brown)
                                .opacity(0.8)
                            Text("Lives: \(playerLives)")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 14)
                    
                    HStack {
                        // Unsichtbarer Platzhalter
                        Button(action: {}) {
                            Image(systemName: "pause")
                                .font(.title)
                                .padding()
                                .background(Color.clear)
                                .clipShape(Circle())
                                .foregroundColor(.clear)
                                .shadow(radius: 10)
                        }
                        Spacer()
                        Text("\(playerScore)")
                            .font(.system(size: 24)) // Größere Schriftgröße
                            .foregroundColor(.yellow) // Andere Farbe
                        Spacer()
                        Button(action: {
                            showGameScene = false
                        }) {
                            Image(systemName: "power")
                                .font(.title)
                                .padding()
                                .background(Color.clear)
                                .clipShape(Circle())
                                .foregroundColor(.brown)
                                .shadow(radius: 10)
                        }
                    }
                    .padding(.leading, 8)
                    .padding(.top, -8)
                }
                .edgesIgnoringSafeArea(.top)
                Spacer()
            }
        }
    }
}


