//
//  AppViewModel.swift
//  Space Invaders Homage
//
//  Created by René Schwarz on 07.08.24.
//

import Foundation

enum GameState {
    case contentview
    case gameplay
    case gameover
    case highscore
}

class AppViewModel: ObservableObject {
    @Published var playerScore: Int = 0
    @Published var playerLives: Int = 3
    @Published var currentGameState: GameState = .contentview
    @Published var currentLevel: Int = 1
    @Published var remainingTime: TimeInterval = 60.0
    @Published var countdownValue: Int = 3
    @Published var countdownFinished: Bool = false
    @Published var showCountdown : Bool = false
    @Published var showGameScene : Bool = false

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
        currentGameState = .contentview // Set the game state back to contentview
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
}
