//
//  GameScene.swift
//  Space Invaders Homage
//
//  Created by Michel Matys on 06.08.24.
//

import SwiftUI
import SpriteKit
import GameKit

struct GameBitmask {
    static let player: UInt32 = 0b1         //1
    static let shipFire: UInt32 = 0b10      //2
    static let enemy: UInt32 = 0b100        //4
    static let enemyFire: UInt32 = 0b1000   //8
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    var playerScore : Binding<Int>
    var playerLives : Binding<Int>
    
    var viewModel: AppViewModel
    
    init(size: CGSize, playerScore: Binding<Int>, playerLives: Binding<Int>, viewModel: AppViewModel) {
        self.playerScore = playerScore
        self.playerLives = playerLives
        self.viewModel = viewModel
        super.init(size: size)


        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let background = SKSpriteNode(imageNamed: "background-space")
    var player = SKSpriteNode(imageNamed: "playerShip")
    var shipFire = SKSpriteNode()
    var enemy = SKSpriteNode()
    var enemyCount: [Int] = [0,0,0,0,0,0]
    var xAxisForEnemyRows: Double = 25
    var fireTimer = Timer()
    var mobFireTimer: Timer?
    var mobFireTimer2: Timer?
    var mobFireTimer3: Timer?
    let hitSound = SKAction.playSoundFileNamed("enemyHit", waitForCompletion: false)
    var enemySum = 0
    var backgroundMusic: SKAudioNode?
    
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        scene?.size = CGSize(width: 400, height: 800)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = self.size
        background.zPosition = 1
        addChild(background)
        
        if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") {
                    backgroundMusic = SKAudioNode(url: musicURL)
                    if let backgroundMusic = backgroundMusic {
                        backgroundMusic.run(SKAction.changeVolume(to: 0.2, duration: 0))
                        addChild(backgroundMusic)
                    }
                }
        
        makePlayer()
        fireTimer = .scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(shipFireFunction), userInfo: nil, repeats: true)
        repeat {
            makeEnemy(xAxis: xAxisForEnemyRows, yAxis: 680, image: "steamPunk-mob1", hitPoints: 3, scoreValue: 30)
            enemyCount[0] += 1
            xAxisForEnemyRows += 35
        } while enemyCount[0] < 10
        xAxisForEnemyRows = 25
        repeat {
            makeEnemy(xAxis: xAxisForEnemyRows, yAxis: 630, image: "steamPunk-mob2", hitPoints: 2, scoreValue: 20)
            enemyCount[1] += 1
            xAxisForEnemyRows += 35
        } while enemyCount[1] < 10
        xAxisForEnemyRows = 25
        repeat {
            makeEnemy(xAxis: xAxisForEnemyRows, yAxis: 580, image: "steamPunk-mob2", hitPoints: 2, scoreValue: 20)
            enemyCount[2] += 1
            xAxisForEnemyRows += 35
        } while enemyCount[2] < 10
        xAxisForEnemyRows = 25
        repeat {
            makeEnemy(xAxis: xAxisForEnemyRows, yAxis: 530, image: "steamPunk-mob3", hitPoints: 1, scoreValue: 10)
            enemyCount[3] += 1
            xAxisForEnemyRows += 35
        } while enemyCount[3] < 10
        xAxisForEnemyRows = 25
        repeat {
            makeEnemy(xAxis: xAxisForEnemyRows, yAxis: 480, image: "steamPunk-mob3", hitPoints: 1, scoreValue: 10)
            enemyCount[4] += 1
            xAxisForEnemyRows += 35
        } while enemyCount[4] < 10
        xAxisForEnemyRows = 25
        repeat {
            makeEnemy(xAxis: xAxisForEnemyRows, yAxis: 430, image: "steamPunk-mob3", hitPoints: 1, scoreValue: 10)
            enemyCount[5] += 1
            xAxisForEnemyRows += 35
        } while enemyCount[5] < 10
        for enemy in enemyCount {
            enemySum += enemy
        }
        mobFireTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { [weak self] _ in
                self?.randomLivingMob()?.fire()
            }
        mobFireTimer2 = Timer.scheduledTimer(withTimeInterval: 9.0, repeats: true) { [weak self] _ in
                self?.randomLivingMob()?.fire()
            }
        mobFireTimer3 = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true) { [weak self] _ in
                self?.randomLivingMob2()?.fire2()
            }
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
            shipFireHitEnemy(fires: contactA.node as! SKSpriteNode, enemies: contactB.node as! Mob)
        } else if contactA.categoryBitMask == GameBitmask.player && contactB.categoryBitMask == GameBitmask.enemy {
            enemy.removeFromParent()
            playerLives.wrappedValue -= 1 // Reduce player lives when the player is hit
            if playerLives.wrappedValue <= 0 {
                player.removeFromParent()
                fireTimer.invalidate()
                stopBackgroundMusic()
                viewModel.showGameoverView()
            }
        } else if contactA.categoryBitMask == GameBitmask.player && contactB.categoryBitMask == GameBitmask.enemyFire {
            
            player.run(SKAction.repeat(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.fadeIn(withDuration: 0.1)]), count: 7))
            
            let explosionAnimation = SKSpriteNode(fileNamed: "Explosion")
            explosionAnimation?.position = player.position
            explosionAnimation?.zPosition = 5
            
            addChild(explosionAnimation!)
            // Hier kannst du hinzufügen, was passiert, wenn das Feuer der Mobs den Spieler trifft
            playerLives.wrappedValue -= 1 // Reduce player lives when the player is hit by enemy fire
            if playerLives.wrappedValue <= 0 {
                player.removeFromParent()
                fireTimer.invalidate()
                stopBackgroundMusic()
                viewModel.showGameoverView()
            }
        }
    }
    
    func randomLivingMob() -> Mob? {
        let livingMobs = children.compactMap { $0 as? Mob }.filter { $0.hitPoints > 0 }
        return livingMobs.randomElement()
    }
    func randomLivingMob2() -> Mob? {
        let livingMobs = children.compactMap { $0 as? Mob }.filter { $0.hitPoints > 2 }
        return livingMobs.randomElement()
    }
    
    func shipFireHitEnemy(fires: SKSpriteNode, enemies: Mob) {
        fires.removeFromParent()
        if enemies.hit(){
            enemySum -= 1
        }
        
        if enemySum == 0 {
            stopBackgroundMusic()
            viewModel.showHighscoreView()
        }
        
        if enemies.parent == nil {
            let score: Int = Int(Double(enemies.scoreValue) * viewModel.highscoreMultiplier)
            playerScore.wrappedValue += score
        }
        
        let explosionAnimation = SKSpriteNode(fileNamed: "Explosion")
        explosionAnimation?.position = enemies.position
        explosionAnimation?.zPosition = 5
        
        addChild(explosionAnimation!)
        
        run(hitSound)
        
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
        
        viewModel.decreaseMultiplier()
        
        let moveAction = SKAction.moveTo(y: 800, duration: 0.7)
        let deleteAction = SKAction.removeFromParent()
        let combine = SKAction.sequence([moveAction,deleteAction])
        
        shipFire.run(combine)
    }
    
    @objc func makeEnemy(xAxis: Double, yAxis: Double, image: String, hitPoints: Int, scoreValue: Int) {
        let enemy = Mob(imageNamed: image, hitPoints: hitPoints, scoreValue: scoreValue)
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
        let combinedMovement = SKAction.repeat(SKAction.sequence([moveRight,moveDown,moveLeft,moveDown]), count: 18)
        
        enemy.run(combinedMovement)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            player.position.x = location.x
        }
    }
    
    func stopBackgroundMusic() {
            backgroundMusic?.removeFromParent()
        }
    
}

#Preview {
    ContentView()
}
