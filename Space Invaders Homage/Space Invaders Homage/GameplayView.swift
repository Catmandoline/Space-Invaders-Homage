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
            VStack{
                VStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .frame(height: 44)
                        Rectangle()
                            .foregroundColor(.brown)
                            .opacity(0.8)
                            .frame(height: 34)
                        
                        HStack {
                            Text("\(viewModel.highestScore())")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                            Spacer()
                            
                            Text("\(viewModel.playerScore)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                                .padding(.horizontal, 10)
                            Spacer()
                            
                            HStack(spacing: 10) {
                                Text("\(viewModel.playerLives)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Image("playerShip")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    .frame(height: 44)
                    .padding(.top, 56)
                    
                    HStack {
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
