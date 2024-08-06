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
    var shipFire = SKSpriteNode()
    
    var fireTimer = Timer()
    
    override func didMove(to view: SKView) {
        scene?.size = CGSize(width: 400, height: 800)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = self.size
        background.zPosition = 1
        addChild(background)
        makePlayer()
        fireTimer = .scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(shipFireFunction), userInfo: nil, repeats: true)
    }
    
    func makePlayer() {
        
        player.position = CGPoint(x: size.width / 2, y: 100)
        player.zPosition = 10
        addChild(player)
    }
    
    @objc func shipFireFunction() {
        shipFire = .init(imageNamed: "projectile")
        shipFire.position = player.position
        shipFire.zPosition = 2
        
        addChild(shipFire)
        
        let moveAction = SKAction.moveTo(y: 800, duration: 0.7)
        let deleteAction = SKAction.removeFromParent()
        let combine = SKAction.sequence([moveAction,deleteAction])
        
        shipFire.run(combine)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            player.position.x = location.x
        }
    }
}

#Preview {
    ContentView()
}
