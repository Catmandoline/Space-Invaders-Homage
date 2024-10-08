//
//  AppViewModel.swift
//  Space Invaders Homage
//
//  Created by René Schwarz on 07.08.24.
//

import Foundation
import SwiftUI
import CoreData

enum GameState {
    case contentview
    case gameplay
    case gameover
    case highscore
}

@Observable class AppViewModel {
    private var dataController = DataController(name: "Model")
    var playerScore: Int = 0
    var playerLives: Int = 3
    var currentGameState: GameState = .contentview
    var currentLevel: Int = 1
    var remainingTime: TimeInterval = 60.0
    var countdownValue: Int = 3
    var countdownFinished: Bool = false
    var showCountdown : Bool = false
    var showGameScene : Bool = false
    var scores: [Score] = []
    var highscoreMultiplier = 20.0
    
    init() {
        fetchData()
    }

    func fetchData() {
        let request = NSFetchRequest<Score>(entityName: "Score")
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
                request.sortDescriptors = [sortDescriptor]
        
        do {
            scores = try dataController.container.viewContext.fetch(request)
        } catch {
            print("Error CoreData")
        }
    }
    
    func highestScore() -> Int {
        let score = scores.sorted { $0.score > $1.score }.first
        return Int(score?.score ?? 0)
    }
    
    func addNewScore(name: String, score: Int) {
        let newScore = Score(context: dataController.container.viewContext)
        newScore.id = UUID()
        newScore.username = name
        newScore.score = Int64(score)
        
        save()
        fetchData()
    }
    
    func save() {
        try? dataController.container.viewContext.save()
    }
    
    // Funktionen zum Aktualisieren des Zustands...
    func increaseScore(by points: Int) {
        playerScore += points
    }

    func decreaseLives(by lives: Int) {
        playerLives -= lives
    }

    func advanceToNextLevel() {
        currentLevel += 1
    }

    func resetGame() {
        playerScore = 0
        playerLives = 3
        currentLevel = 1
        remainingTime = 60.0
        countdownValue = 3
        countdownFinished = false
        currentGameState = .contentview
    }

    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countdownValue > 0 {
                self.countdownValue -= 1
            } else {
                timer.invalidate()
                self.currentGameState = .gameplay
            }
        }
    }
    
    func showHighscoreView() {
        self.currentGameState = .highscore
    }
    
    func showTitleScreen() {
        self.currentGameState = .contentview
    }
    
    func showGameoverView() {
        self.currentGameState = .gameover
    }
    
    func decreaseMultiplier() {
        highscoreMultiplier -= 0.1
    }
}
