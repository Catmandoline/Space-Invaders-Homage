//
//  ContentView.swift
//  Space Invaders Homage
//
//  Created by Michel Matys on 05.08.24.
//

import SwiftUI
import SpriteKit
import GameKit

struct ContentView: View {
    @State private var showGameScene = false
    @State private var playerName = ""
    @State private var playersMaxScore = 0
    @State private var playerLives = 3
    @State private var playerScore = 0
    
    var body: some View {
        ZStack {
            if !showGameScene {
                Image("background-contenview")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                    
                    Button("Spiel Starten") {
                        showGameScene = true
                    }
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 150)
                }
            }
            
            if showGameScene {
                SpriteView(scene: GameScene())
                    .ignoresSafeArea()
                HStack {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(maxWidth: 120, maxHeight: 30)
                            .foregroundColor(.brown)
                        Text("Score: \(playerScore)")
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(maxWidth: 120, maxHeight: 30)
                            .foregroundColor(.brown)
                    
                        Text("Lives: \(playerLives)")
                            .foregroundColor(.white)
                            
                    }
                    
                }
                .padding(.horizontal, 10)
                Spacer()
                
            }
        }
    }
}


#Preview {
    ContentView()
}
