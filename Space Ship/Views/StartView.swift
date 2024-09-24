
import UIKit

class StartView: UIView{
    
    
   // Butons
    var musicButton: UIButton!
    var startButton: UIButton!
    var settingButton: UIButton!
    
    func config(){
        let backImageName: String = "StartBackgroundImage"
        self.backgroundColor = UIColor(patternImage: UIImage(named: backImageName)!)
        makeMusicButton()
        makeStartButton()
        makeSettingButton()
    }
       

        // Creating Start Button
        func makeStartButton(){
            startButton = UIButton(frame: CGRect(x: 1, y: 2, width: 150, height: 150))
            startButton.setImage(UIImage(named: "Start"), for: .normal)
            self.addSubview(startButton)
            startButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(180)
                make.size.equalTo(200)
            }
       
        }
        
        //  Creating music Button
        func makeMusicButton(){
            musicButton = UIButton(frame: CGRect(x: 1, y: 2, width: 100, height: 100))
            var imageName: String
            switch storage.loadMusicCondition(){
            case true: imageName = "Music On"
            case false: imageName = "Music Off"
            }
            musicButton.setImage(UIImage(named: imageName), for: .normal)
            self.addSubview(musicButton)
           
            musicButton.snp.makeConstraints { make in
                make.size.equalTo(130)
                make.centerY.equalTo(self.snp.top).inset(150)
                make.left.equalToSuperview().inset(40)
            }
          
    }
    
    func turnOffMusic(){
        musicButton.setImage(UIImage(named: "Music Off"), for: .normal)
    }
    func turnOnMusic(){
        musicButton.setImage(UIImage(named: "Music On"), for: .normal)
    }
        
        //  Creating setting Button
        
        func makeSettingButton(){
            settingButton = UIButton(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
            self.addSubview(settingButton)
            settingButton.setImage(UIImage(named: "SettingImage"), for: .normal)
            settingButton.snp.makeConstraints { make in
                make.centerY.equalTo(self.snp.top).inset(150)
                make.right.equalToSuperview().inset(50)
                make.size.equalTo(130)
            }
        }

}
