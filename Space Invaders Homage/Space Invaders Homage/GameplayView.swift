//
//  GameplayView.swift
//  Space Invaders Homage
//
//  Created by René Schwarz on 07.08.24.
//

import SwiftUI
import SpriteKit

struct GameplayView: View {
    @Binding var viewModel: AppViewModel

    var body: some View {
        if viewModel.showGameScene && viewModel.countdownFinished {
            SpriteView(scene: GameScene(size: CGSize(width: 400, height: 800),playerScore: $viewModel.playerScore, playerLives: $viewModel.playerLives, viewModel: viewModel))
                        .ignoresSafeArea()
            
            VStack {
                VStack{
                    HStack {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: 120, maxHeight: 30)
                                .foregroundColor(.brown)
                                .opacity(0.8)
                            Text("HighScore: \(viewModel.highestScore())") 
                                .foregroundColor(.white)
                        }
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: 120, maxHeight: 30)
                                .foregroundColor(.brown)
                                .opacity(0.8)
                            Text("Lives: \(viewModel.playerLives)") // Verwende viewModel.playerLives
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
                        Text("\(viewModel.playerScore)")
                            .font(.system(size: 24))
                            .foregroundColor(.yellow)
                        Spacer()
                        Button(action: {
                            viewModel.currentGameState = .contentview
                            viewModel.countdownFinished = false
                            viewModel.resetGame()
                            
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
