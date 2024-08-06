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
    
    let scene = GameScene()
    
    var body: some View {
       SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}


#Preview {
    ContentView()
}
