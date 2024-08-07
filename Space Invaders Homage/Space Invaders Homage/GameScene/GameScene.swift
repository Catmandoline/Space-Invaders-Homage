//
//  GameScene.swift
//  Space Invaders Homage
//
//  Created by Michel Matys on 06.08.24.
//

import SwiftUI
import SpriteKit
import GameKit

class GameScene: SKScene, SKPhysicsContactDelegate {
   var playerScore : Binding<Int>
    
    init(size: CGSize, playerScore: Binding<Int>) {
        self.playerScore = playerScore
        super.init(size: size)
    
        }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
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
        
        physicsWorld.contactDelegate = self
        scene?.size = CGSize(width: 400, height: 800)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = self.size
        background.zPosition = 1
        addChild(background)
        makePlayer()
        fireTimer = .scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(shipFireFunction), userInfo: nil, repeats: true)
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 680, image: "steamPunk-mob1")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 630, image: "steamPunk-mob2")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 580, image: "steamPunk-mob2")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 530, image: "steamPunk-mob3")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 480, image: "steamPunk-mob3")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
        enemyCountInRow = 0
        xAxisForEnemyRows = 25
        repeat {
            makeEnemieRow(xAxis: xAxisForEnemyRows, yAxis: 430, image: "steamPunk-mob3")
            enemyCountInRow += 1
            xAxisForEnemyRows += 35
        } while enemyCountInRow < 10
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA: SKPhysicsBody
        let contactB: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            contactA = contact.bodyA
            contactB = contact.bodyB
        } else {
            contactA = contact.bodyB
            contactB = contact.bodyA
        }
        
        if contactA.categoryBitMask == GameBitmask.shipFire && contactB.categoryBitMask == GameBitmask.enemy {
            shipFireHitEnemy(fires: contactA.node as! SKSpriteNode, enemies: contactB.node as! SKSpriteNode)
        }
        if contactA.categoryBitMask == GameBitmask.player && contactB.categoryBitMask == GameBitmask.enemy {
            enemy.removeFromParent()
            player.removeFromParent()
            fireTimer.invalidate()
        }
    }
    
    func shipFireHitEnemy(fires: SKSpriteNode, enemies: SKSpriteNode) {
            fires.removeFromParent()
            enemies.removeFromParent()
            
            let explo = SKSpriteNode(fileNamed: "Explosion")
            explo?.position = enemies.position
            explo?.zPosition = 5
            
            addChild(explo!)

            playerScore.wrappedValue += 1 // Increase the score when an enemy is hit
        }

    
    func makePlayer() {
        
        player.position = CGPoint(x: size.width / 2, y: 70)
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
        
        let moveRight = SKAction.move(by: CGVector(dx: 40, dy: 0), duration: 6)
        let moveDown = SKAction.move(by: CGVector(dx: 0, dy: -20), duration: 4)
        let moveLeft = SKAction.move(by: CGVector(dx: -40, dy: 0), duration: 6)
        let combinedMovement = SKAction.sequence([moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown,moveRight,moveDown,moveLeft,moveDown])
        
        enemy.run(combinedMovement)
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
