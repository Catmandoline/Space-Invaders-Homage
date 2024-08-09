//
//  ContentView.swift
//  Space Invaders Homage
//
//  Created by Michel Matys on 05.08.24.
//

import SwiftUI
import SpriteKit
import GameKit


struct ContentView: View {
    @State var viewModel = AppViewModel() // Erstelle eine Instanz von AppViewModel
    var body: some View {
        ZStack {
            Image("background-contenview")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
            if viewModel.showCountdown {
                CountdownOverlay(countdownFinished: $viewModel.countdownFinished, showCountDown: $viewModel.showCountdown, showGameScene: $viewModel.showGameScene)
            }
            switch viewModel.currentGameState {
            case .contentview:
                VStack {
                    Text("STEAM PUNK \n INVADERS")
                        .font(.custom("FabulousSteampunk", size: 48))
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 10)
                        .padding(.top, 170)
                    Spacer()
                    List {
                        Section(header: Text("High Score")
                            .font(.custom("FabulousSteampunk", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.clear)
                            .listRowInsets(EdgeInsets())) {
                                ForEach(viewModel.scores) { score in
                                    HStack {
                                        Text(score.username ?? "Unknown")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("\(score.score)")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                    .listRowBackground(Color.brown.opacity(0.5))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10) // Abgerundeter Rahmen
                                            .stroke(Color.white, lineWidth: 1) // Weiße Linie für den Outline
                                            .shadow(color: .white.opacity(0.3), radius: 5) // Leichter Glow-Effekt
                                            .padding(-8)
                                    )
                                }
                            }
                    }
                    .listStyle(SidebarListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color.clear) // Transparenter Hintergrund für die gesamte Liste
                    .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 10) // Schatten für den Schwebeeffekt
                    .padding(.top,20)
                    Spacer()
                    Button("Spiel Starten") {
                        viewModel.showCountdown = true
                    }
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.bottom, 75)
                }
            case .gameplay:
                if viewModel.countdownFinished {
                    GameplayView(viewModel: $viewModel) // Gib die Instanz von AppViewModel an GameplayView weiter
                }
            case .gameover:
                GameOverView(viewModel: $viewModel)
            case .highscore:
                HighScoreView(viewModel: viewModel)
            }
        }
        .onChange(of: viewModel.countdownFinished) { oldValue, newValue in
            if newValue {
                viewModel.currentGameState = .gameplay
            }
        }
    }
}
struct CountdownOverlay: View {
    @Binding var countdownFinished: Bool
    @Binding var showCountDown: Bool
    @Binding var showGameScene: Bool
    @State private var countdown = 3
    var body: some View {
        if countdown > 0 {
            ZStack {
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                Text("\(countdown)")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            if countdown > 1 {
                                countdown -= 1
                            } else {
                                timer.invalidate()
                                countdownFinished = true
                                showCountDown = false
                                showGameScene = true
                            }
                        }
                    }
            }
            .edgesIgnoringSafeArea(.all) // Ignoriere Safe Area, um das Overlay auf den gesamten Bildschirm auszudehnen
        }
    }
}
#Preview {
    ContentView()
}
