//
//  GameView.swift
//  Evasions
//
//  Created by Ivan Pushkov on 23.09.2024.
//

import UIKit
import SnapKit
import SpriteKit

class GameView: SKView{
    
    var pauseButton: UIButton!
    var startLable: UILabel!
    var gameScene: GameScene!
    
    
    
    
    func configView(){
      
        makeStartlable()
        makePauseButon()
        makeScene()
        
    }
    // создаем лейбл старта
    func makeStartlable(){
        startLable  = UILabel(frame: CGRect(x: 1, y: 1, width: 200, height: 200))
        startLable.font = UIFont(name: "Helvetica", size: 55)
        startLable.textColor = .white
        self.addSubview(startLable)
        startLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
        }
       
    }
    
    func makePauseButon(){
        pauseButton = UIButton()
        pauseButton.setImage(UIImage.init(named: "Пауза"), for: .normal)
        self.addSubview(pauseButton)
        pauseButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.top.equalToSuperview().offset(100)
            make.rightMargin.equalToSuperview().inset(20)
        }
        
        
    }
    
    
    func makeScene(){  
            // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            self.gameScene = scene as? GameScene
            // Present the scene
            self.presentScene(scene)
        }
    }
    
}
