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
    var enemy = SKSpriteNode()
    var enemyCountInRow: Int = 0
    var xAxisForEnemyRows: Double = 25
    var testCOunt: Int = 0
    var fireTimer = Timer()
    
    struct GameBitmask {
        static let player: UInt32 = 0b1     //1
        static let shipFire: UInt32 = 0b10  //2
        static let enemy: UInt32 = 0b100    //4
    }
    
    override func didMove(to view: SKView) {
        scene?.size = CGSize(width: 400, height: 800)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = self.size
        background.zPosition = 1
        addChild(background)
        makePlayer()
        fireTimer = .scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(shipFireFunction), userInfo: nil, repeats: true)
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 700, image: "steamPunk-mob1")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 650, image: "steamPunk-mob2")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 600, image: "steamPunk-mob2")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 550, image: "steamPunk-mob3")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 500, image: "steamPunk-mob3")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 450, image: "steamPunk-mob3")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
    }
    
    func makePlayer() {
        
        player.position = CGPoint(x: size.width / 2, y: 100)
        player.setScale(0.5)
        player.zPosition = 10
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = GameBitmask.player
        player.physicsBody?.contactTestBitMask = GameBitmask.enemy
        player.physicsBody?.collisionBitMask = GameBitmask.enemy
        addChild(player)
    }
    
    @objc func shipFireFunction() {
        shipFire = .init(imageNamed: "projectile")
        shipFire.setScale(0.2)
        shipFire.position = player.position
        shipFire.zPosition = 2
        shipFire.physicsBody = SKPhysicsBody(rectangleOf: shipFire.size)
        shipFire.physicsBody?.affectedByGravity = false
        shipFire.physicsBody?.categoryBitMask = GameBitmask.shipFire
        shipFire.physicsBody?.contactTestBitMask = GameBitmask.enemy
        shipFire.physicsBody?.collisionBitMask = GameBitmask.enemy
        
        addChild(shipFire)
        
        let moveAction = SKAction.moveTo(y: 800, duration: 0.7)
        let deleteAction = SKAction.removeFromParent()
        let combine = SKAction.sequence([moveAction,deleteAction])
        
        shipFire.run(combine)
    }
    
    @objc func makeEnemieRow(xAxis: Double, yAxis: Double, image: String) {
        enemy = .init(imageNamed: image)
        enemy.position = CGPoint(x: xAxis, y: yAxis)
        enemy.zPosition = 5
        enemy.setScale(0.13)
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask = GameBitmask.enemy
        enemy.physicsBody?.contactTestBitMask = GameBitmask.player | GameBitmask.shipFire
        enemy.physicsBody?.collisionBitMask = GameBitmask.player | GameBitmask.shipFire
        
        addChild(enemy)
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
