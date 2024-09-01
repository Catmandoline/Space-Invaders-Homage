# Space Invaders Homage

Eine Hommage an das klassische Space Invaders Spiel, entwickelt mit Swift und SpriteKit.

## Voraussetzungen

- Xcode Version XYZ
- Swift Version XYZ

## Installation

1. Klone das Repository:
    ```bash
    git clone https://github.com/dein-benutzername/space-invaders-homage.git
    ```
2. Öffne das Projekt in Xcode:
    ```bash
    cd space-invaders-homage
    open space-invaders-homage.xcodeproj
    ```

## Verwendung

1. Baue und starte das Projekt in Xcode.
2. Folge den Anweisungen auf dem Bildschirm, um das Spiel zu spielen.

## Funktionen

- Klassisches Space Invaders Gameplay
- Verschiedene Gegner mit unterschiedlichen Hitpoints und Punktwerten
- Hintergrundmusik und Soundeffekte
- Highscore-System

## Codeübersicht

### GameScene.swift

Die `GameScene`-Klasse ist verantwortlich für das Hauptspielgeschehen, einschließlich der Spieler- und Gegnerlogik, Kollisionsbehandlung und Soundeffekte.

### ContentView.swift

Die `ContentView`-Struktur verwaltet die verschiedenen Ansichten des Spiels, wie das Hauptmenü, das Gameplay und die Highscore-Anzeige.

### GameplayView.swift

Die `GameplayView`-Struktur zeigt die eigentliche Spielszene an und enthält die Benutzeroberfläche für das Spiel.

### GameOverView.swift

Die `GameOverView`-Struktur zeigt den Game-Over-Bildschirm an und ermöglicht es dem Spieler, seinen Highscore zu speichern.

## Bekannte Probleme

- **Modellabhängigkeit**: Nach dem Klonen des Repositories muss das Modell manuell entfernt und erneut aus dem Ordner hinzugefügt werden, um die Abhängigkeit korrekt zu finden.

## Mitwirkende

- René Schwarz
- Michel Matys
- Mirco Lange

## Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert – siehe die LICENSE Datei für Details.

