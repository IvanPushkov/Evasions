

import UIKit

class StartController: UIViewController {
  
    var gameController = GameController()
    
    var musicSoundDelegate: MusicAndSoundDelegateProtocol!
   
    var startView: StartView!
        

    override func viewDidLoad() {
        super.viewDidLoad()
        setStartView()
    }
    
    
    // Setting View with objects and targets to ViewConTroller
    func setStartView(){
        startView = StartView()
        startView.config()
        startView.startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        startView.musicButton.addTarget(self, action: #selector(musicAction), for: .touchUpInside)
        startView.settingButton.addTarget(self, action: #selector(settingButtonAction), for: .touchUpInside)
        view = startView
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // NewGame after reload
        gameController = GameController()
    }
    
  
    
 
    
    @objc func startAction(){
        navigationController?.pushViewController(gameController, animated: true)
    }
    
    @objc func musicAction(){
        gameController.musicDelegateButton(viewController: self)
    }

    @objc func settingButtonAction(){
        let settingController = PauseSettingController()
        settingController.showPauseButton = false
        navigationController?.pushViewController(settingController, animated: true)
    }

}
