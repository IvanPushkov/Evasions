//
//  UserRecord.swift
//  Space Ship
//
//  Created by Ivan Pushkov on 05.08.2024.
//

import Foundation



final class UserDefaultData{
    
  
    let storage = UserDefaults.standard
    var corentResult = 0
   
    
    var speedTraficKey: String = "SpeedTrafic"
    var speedCarKey: String =  "SpeedCar"
    var scoreKey: String = "maxScore"
    var musicValueKey: String = "MusicValue"
    var musicIsOnKey: String = "MusicIsOn"
    
    
    func saveScore(){
        let maxScoreFromStorage = storage.integer(forKey: "maxScore")
        if corentResult > maxScoreFromStorage{
            storage.set(corentResult, forKey: scoreKey)
        }
    }
    
    func loadScore() -> Int{
        let maxScoreFromStorage = storage.integer(forKey: scoreKey)

        if maxScoreFromStorage > corentResult  {
            return maxScoreFromStorage
        } else {
            return corentResult
        }
        
    }
    
   
    // saving and loading new speed of Car
   
    func saveSpeedCar(newSpeed: Double){
        storage.set(newSpeed, forKey: speedCarKey)
    }
    func loadSpeedCar()-> Double {
       storage.double(forKey: speedCarKey)
    }
    
    //  saving and loading new speed of trafic
    func saveSpeedTrafic(newSpeed: Double){
        storage.set(newSpeed, forKey: speedTraficKey)
    }
    
    func loadSpeedTrafic()-> Double {
       storage.double(forKey: speedTraficKey)
    }
    //  saving and loading new value of music
    
    func loadValueMusic() -> Double{
        storage.double(forKey: musicValueKey)
    }
    func saveValueMusic(newValue: Double){
        storage.set(newValue, forKey: musicValueKey)
    }
    
    // saving and loading condition music
    func changeMusicCondition(){
        if storage.bool(forKey: musicIsOnKey) == true{
            storage.set(false, forKey: musicIsOnKey)
        } else if storage.bool(forKey: musicIsOnKey) == false{
            storage.set(true, forKey: musicIsOnKey)
        } else {
            storage.set(true, forKey: musicIsOnKey)
        }
        
    }
    func loadMusicCondition() -> Bool{
        storage.bool(forKey: musicIsOnKey) 
        
    }
}

var storage = UserDefaultData()
