//
//  Game.swift
//  Evasions
//
//  Created by Ivan Pushkov on 24.09.2024.
//

import Foundation


protocol GameProtocol{
    
    var score: Int {get set}
    
    var gameIsEnd: Bool {get set}
    
    var gameIsPause: Bool {get set}
    
    var pauseSpeed: Int {get set}
    
    
    func showCorentScore() -> String
    func pauseTheGame()
    func unpauseTheGame()
    func addPoint()
    
}

class Game: GameProtocol{
    
    
    var score: Int = 0
    
    var gameIsEnd: Bool = false
    
    var gameIsPause: Bool = false
    
    var pauseSpeed: Int = 0
    
    func pauseTheGame() {
        gameIsPause = true
        pauseSpeed = 0
    }
    
    func unpauseTheGame() {
        gameIsPause = false
    }
    
    func addPoint(){
        score += 1
    }
    func showCorentScore() -> String {
        return "Score - \(score)"
    }
 
}
