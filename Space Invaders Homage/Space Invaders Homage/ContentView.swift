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
    
    
    var body: some View {
        ZStack {
            Image("background-contenview")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
            
            if showGameScene {
                SpriteView(scene: GameScene())
                    .ignoresSafeArea()
            }
            
            VStack {
                Button("Spiel Starten") {
                    showGameScene = true
                }
                .padding()
                .background(Color.brown)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100)
            }
        }
    }
}


#Preview {
    ContentView()
}
