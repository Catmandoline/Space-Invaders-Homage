//
//  GameScene.swift
//  Space Invaders Homage
//
//  Created by Michel Matys on 06.08.24.
//

import SwiftUI
import SpriteKit
import GameKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "background-space")
    var player = SKSpriteNode(imageNamed: "playerShip")
    
    override func didMove(to view: SKView) {
        scene?.size = CGSize(width: 400, height: 800)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.setScale(1.34)
        background.zPosition = 1
        addChild(background)
        makePlayer()
    }
    
    func makePlayer() {
        
        player.position = CGPoint(x: size.width / 2, y: 100)
        player.zPosition = 10
        addChild(player)
        
    }
}

#Preview {
    ContentView()
}
