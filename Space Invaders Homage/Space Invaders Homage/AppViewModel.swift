//
//  AppViewModel.swift
//  Space Invaders Homage
//
//  Created by René Schwarz on 07.08.24.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var playerScore: Int = 0
    @Published var playerLives: Int = 3
    @Published var currentGameState: GameState = .contentview
    @Published var currentLevel: Int = 1
    @Published var remainingTime: TimeInterval = 60.0

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
        currentGameState = .contentview // Set the game state back to contentview
    }
}
