//
//  GameOverView.swift
//  Space Invaders Homage
//
//  Created by René Schwarz on 07.08.24.
//

import SwiftUI

struct HighScoreView: View {
    var viewModel: AppViewModel
    @State private var username: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("HIGH SCORE")
                .foregroundColor(.yellow)
                .font(.custom("FabulousSteampunk", size: 46))
                .bold()
            Text("\(viewModel.playerScore)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(20)
            
            HStack {
                TextField("Enter your username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(18)
                
                Button(action: {
                    viewModel.addNewScore(name: username, score: viewModel.playerScore)
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
    HighScoreView(viewModel: AppViewModel())
}
