//
//  Mob.swift
//  Space Invaders Homage
//
//  Created by René Schwarz on 07.08.24.
//

import SwiftUI
import SpriteKit


class Mob: SKSpriteNode {
    var hitPoints: Int
    var scoreValue: Int
    var mobFire: SKSpriteNode?
    
    init(imageNamed: String, hitPoints: Int, scoreValue: Int) {
        self.hitPoints = hitPoints
        self.scoreValue = scoreValue
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit() -> Bool { // Returns true on kill
        hitPoints -= 1
        if hitPoints <= 0 {
            removeFromParent()
            return true
        }
        return false
    }
    
    @objc func fire() {
        mobFire = SKSpriteNode(imageNamed: "enemy-projectile")
        mobFire?.setScale(0.2)
        mobFire?.position = self.position
        mobFire?.zPosition = 5
        mobFire?.physicsBody = SKPhysicsBody(rectangleOf: mobFire!.size)
        mobFire?.physicsBody?.affectedByGravity = false
        mobFire?.physicsBody?.categoryBitMask = GameBitmask.enemyFire
        mobFire?.physicsBody?.contactTestBitMask = GameBitmask.player
        mobFire?.physicsBody?.collisionBitMask = GameBitmask.player
        
        
        let moveAction = SKAction.moveTo(y: -800, duration: 2)
        let deleteAction = SKAction.removeFromParent()
        let actionSequence = SKAction.sequence([moveAction, deleteAction])
        
        mobFire?.run(actionSequence)
        
        if let fire = mobFire {
            self.parent?.addChild(fire)
        }
    }
    
}
