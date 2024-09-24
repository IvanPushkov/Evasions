//
//  GameViewController.swift
//  Space Ship
//
//  Created by Ivan Pushkov on 10.07.2024.
//

import UIKit
import SpriteKit
import GameplayKit

import AVFoundation

class GameController: UIViewController{
    
    var musicPlayer = AVPlayer()
   
    var timer = Timer()
    
    let pauseController = PauseSettingController()
    
    var gameView: GameView!
    
    var timeBeforeStart = 3.0
    
    
    override func loadView() {
        super.loadView()
        setGameView()
        
     }
    
    func setGameView(){
        gameView = GameView()
        gameView.configView()
        gameView.gameScene.defeatDelegate = self
        gameView.startLable.text = "\(Int(timeBeforeStart))"
        gameView.pauseButton.addTarget(self, action: #selector(pouseAction), for: .touchUpInside)
        gameView.gameScene.pouseAction()
        gameView.ignoresSiblingOrder = true
        self.view = gameView
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseController.pauseDelegate = self
        pauseController.musicSoundDelegate = self
        
        // Скрываем NavBar
        navigationController?.setNavigationBarHidden(true, animated: true)

        // Описываем включение музыкального плеера
        do{
            if let pathOfMusicPlayer = Bundle.main.path(forResource: "phoneMusic", ofType: "mp3") {
                musicPlayer =  AVPlayer(url: NSURL(fileURLWithPath: pathOfMusicPlayer) as URL)
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.musicPlayer.currentItem, queue: .main) { [weak self] _ in
                    self?.musicPlayer.seek(to: CMTime.zero)
                    self?.musicPlayer.play()
                }
                print ("find music")
                if storage.loadMusicCondition(){
                    musicPlayer.play()
                    
                    musicPlayer.volume = Float(storage.loadValueMusic())
                }
            }
        }
    }
  
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        // Ставим на паузу игру и снимаем ее с нее через 2 секунды при запуске
        if let view = self.view as? GameView{
            
            view.gameScene.pouseAction()
        }
         timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(launchTheGame), userInfo: nil, repeats: true)
    }
    
    @objc func launchTheGame(){
        timeBeforeStart -= 1
        if let view = self.view as? GameView{
            view.startLable.text = ("\(Int(timeBeforeStart))")
            if timeBeforeStart == 0{
                timer.invalidate()
                view.gameScene.pouseAction()
                view.startLable.isHidden = true
            }
            
            if storage.loadMusicCondition(){
                view.gameScene.soundIsOn = true
                
            } else {
                view.gameScene.soundIsOn = false
            }
        }
    }
    
    
    @objc func pouseAction(){
        showPauseScreen(pauseController)
        if timeBeforeStart != 0{
            timer.invalidate()
        } else{
            gameView.gameScene.pouseAction()
        }
    }
    
    
    
    func showPauseScreen(_ viewController: UIViewController){
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        UIView.animate(withDuration: 1.6) {
            viewController.view.alpha = 0.8
        }
    }
    
 
    
    func hidePauseScreen(viewController: UIViewController){
        if let pauseController = viewController as? PauseSettingController{
            pauseController.willMove(toParent: nil)
            pauseController.removeFromParent()
            pauseController.view.removeFromSuperview()
        }
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
 
}


extension GameController{
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        musicPlayer.pause()
    }
}

//MARK: -  Расширяем класс GameViewController  делегируя ему обработку действий

// ДОбавляем делегат паузы
extension GameController:PauseVCDelegateProtocol {
  
    func pauseVCPlayButton(pauseVC: UIViewController) {
        UIView.animate(withDuration: 1.5) {
            pauseVC.view.alpha = 0
        } completion: { make in
            self.hidePauseScreen(viewController: pauseVC  )
            if self.timeBeforeStart != 0{
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.launchTheGame), userInfo: nil, repeats: true)
            } else{
                self.gameView.gameScene.pouseAction()
            }
                      }
        }
        
    }



// Добавляем обработку делегатов от StartVC

extension GameController: MusicAndSoundDelegateProtocol{
    
    func musicDelegateButton(viewController: UIViewController) {
        do{
            if let startVC = viewController as? StartController{
                if storage.loadMusicCondition() {
                    musicPlayer.pause()
                    startVC.startView.turnOffMusic()
                    storage.changeMusicCondition()
                    print("music OFF")
              
                } else {
                    musicPlayer.play()
                    storage.changeMusicCondition()
                    startVC.startView.turnOnMusic()
                    print("music ON")
                }
            }
        }
    }
    
    
    func musicValueChangeDelegate(newValue: Float){
        musicPlayer.volume = newValue
    }
  
}

extension GameController: DefeatDelegateProtocol{
    func defeatAction(viewController: UIViewController) {
        musicPlayer.pause()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}



