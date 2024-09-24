//
//  PauseViewController.swift
//  Space Ship
//
//  Created by Ivan Pushkov on 17.07.2024.
//

import UIKit



class PauseSettingController: UIViewController {
    
    var pauseSetingView: PauseSettingView!
    
    var pauseDelegate: PauseVCDelegateProtocol?
    
    var musicSoundDelegate: MusicAndSoundDelegateProtocol?
    
    var showPauseButton: Bool  = true
    
    override func viewDidLoad() {
       
        // настройка view
        self.navigationItem.setHidesBackButton(true, animated: true)
        configureView()
       
    }
    
    
    
    func configureView(){
        pauseSetingView = PauseSettingView()
        pauseSetingView.showPauseButton = showPauseButton
        pauseSetingView.config()
        pauseSetingView.speedCarSlider.addTarget(self, action: #selector(changeSpeed), for: .valueChanged)
        pauseSetingView.traficSlider.addTarget(self, action: #selector(changeTraficSpeed), for: .valueChanged)
        pauseSetingView.musicSlider.addTarget(self, action: #selector(changeMusicSlider), for: .valueChanged)
        pauseSetingView.backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        pauseSetingView.pauseButton.addTarget(self, action: #selector(pauseBtAction), for: .touchUpInside)
       
        view = pauseSetingView
    }
   
    
    @objc func pauseBtAction(){
        pauseDelegate?.pauseVCPlayButton(pauseVC: self)
    }
    
    @objc func changeSpeed(){
        storage.saveSpeedCar(newSpeed: Double(pauseSetingView.speedCarSlider.value))
        pauseSetingView.speedCarLable.text = "Скорость монстра - \(Int(pauseSetingView.speedCarSlider.value)/40) km/h"
    }
    
    
    @objc func changeTraficSpeed(){
        storage.saveSpeedTrafic(newSpeed: Double(pauseSetingView.traficSlider.value))
        pauseSetingView.traficLable.text = "Встречных монстров в секунду - \(round(pauseSetingView.traficSlider.value * 10) / 10)"
    }
    
   
    @objc func changeMusicSlider(){
        storage.saveValueMusic(newValue: Double(pauseSetingView.musicSlider.value))
        musicSoundDelegate?.musicValueChangeDelegate(newValue: pauseSetingView.musicSlider.value)
        pauseSetingView.musicLable.text = "Громкость музыки - \(Int(pauseSetingView.musicSlider.value * 10) )"
    }
    
  
            @objc func backButtonAction(){
                navigationController?.popToRootViewController(animated: true)
                var arrayControllers = navigationController?.viewControllers
                var count = (arrayControllers?.count ?? 0) - 1
                for vc in arrayControllers!{
                    if ((vc as? GameController) != nil) {
                        arrayControllers?.remove(at: count)
                    }
                    count -= 1
                }
                storage.saveScore()
                }
    
    
}
