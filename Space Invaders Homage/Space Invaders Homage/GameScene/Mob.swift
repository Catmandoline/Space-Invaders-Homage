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
    
    init(imageNamed: String, hitPoints: Int, scoreValue: Int) {
        self.hitPoints = hitPoints
        self.scoreValue = scoreValue
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit() {
        hitPoints -= 1
        if hitPoints <= 0 {
            removeFromParent()
        }
    }
}
