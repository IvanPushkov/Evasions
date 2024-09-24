//
//  MusicPlayer.swift
//  Evasions
//
//  Created by Ivan Pushkov on 24.09.2024.
//

import Foundation

protocol MusicPlayerProtocol{
    
    var maxValue: Float {get set}
    var minValue: Float { get set}
    
    var playerIsOn: Bool {get set}
    
    func startPlayer()
    func stopPlayer()
    
}


class MusicPlayer: MusicPlayerProtocol{
    static let musicPlayer = MusicPlayer()
    
    var maxValue: Float = 1.0
    
    var minValue: Float = 0.0
    
    var playerIsOn: Bool = true
    
    func startPlayer() {
        playerIsOn = true
    }
    
    func stopPlayer() {
        playerIsOn = false
    }
    
    
}

var musicPlayer = MusicPlayer.musicPlayer

