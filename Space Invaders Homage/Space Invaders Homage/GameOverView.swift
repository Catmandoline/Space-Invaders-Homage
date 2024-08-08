//
//  GameOverView.swift
//  Space Invaders Homage
//
//  Created by René Schwarz on 07.08.24.
//

import SwiftUI

struct GameOverView: View {
    @Binding var viewModel: AppViewModel
    @State private var username: String = ""

    var body: some View {
        VStack {
            Spacer()
            Text("Game Over")
                .foregroundColor(.red)
                .font(.largeTitle)
                .bold()
            Text("\(viewModel.playerScore)")
                .foregroundColor(.white)
                .font(.title)
                .padding(20)
            
            
            HStack {
                TextField("Enter your username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(18)
                
                Button(action: {
                    viewModel.addNewScore(name: username, score: viewModel.playerScore)
                    viewModel.showTitleScreen()
                    viewModel.resetGame()
                }) {
                    Text("Save")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .padding()
                
            }
            Button(action: {
                            viewModel.showTitleScreen()
                            viewModel.resetGame()
                        }) {
                            Text("Back to menu")
                                .padding()
                                .background(Color.brown)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                        .padding()
            
            Spacer()
        }
    }
}


#Preview {
    GameOverView(viewModel: .constant(AppViewModel()))
}

