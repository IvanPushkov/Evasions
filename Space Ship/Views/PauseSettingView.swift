

import UIKit
import SnapKit


class PauseSettingView: UIView{
    
    var speedCarLable = UILabel()
    var traficLable = UILabel()
    var musicLable = UILabel()
    var soundLable = UILabel()
    
    var pauseButton =  UIButton()
    var backButton = UIButton()
    
    var speedCarSlider = UISlider()
    var traficSlider = UISlider()
    var soundSlider = UISlider()
    var musicSlider = UISlider()
    
    var showPauseButton =  true
    let imageName = "PausePhone"
   
  
     // view Configuration
    func config(){
        self.backgroundColor = UIColor(patternImage: UIImage(named: imageName)! )
        self.layer.opacity = 0.5
        
        makeCarLable()
        makeTraficLable()
        makeMusicLable()
        
        makeCarSlider()
        makeTraficSlider()
        makeMusicSlider()
        
        makePouseButton()
        makeBackButton()
    
    }
  
    // Creating PauseButton
    func makePouseButton(){
        pauseButton = UIButton(frame: CGRect(x: 10, y: 100, width: 300, height: 20))
        self.addSubview(pauseButton)
        pauseButton.setImage(UIImage(named: "Пауза"), for: .normal)
        pauseButton.sizeToFit()
        
        if showPauseButton == false {
            pauseButton.isHidden = true
        }
        pauseButton.snp.makeConstraints { make in
            make.size.equalTo(90)
            make.center.equalToSuperview()
        }
    }
    
    // Creating Slider for speed of Main Character
    func makeCarSlider(){
        speedCarSlider = UISlider(frame: CGRect(x: 200, y: 200, width: 300, height: 50))
        speedCarSlider.thumbTintColor = .orange
        speedCarSlider.minMaxValues(min: 100.0, max: 1000.0)
        speedCarSlider.minimumTrackTintColor = .blue
        speedCarSlider.value = Float(storage.loadSpeedCar())
        speedCarSlider.center = self.center
        self.addSubview(speedCarSlider)
        speedCarSlider.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(90)
        }
        
    }
    
    // Creating Slider for change of trafic
    func makeTraficSlider(){
        traficSlider = UISlider(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        traficSlider.minMaxValues(min: 0.7, max: 1.8)
        traficSlider.thumbTintColor = .orange
        traficSlider.minimumTrackTintColor = .blue
        traficSlider.value = Float(storage.loadSpeedTrafic())
        self.addSubview(traficSlider)
        traficSlider.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(30)
            make.top.equalTo(speedCarSlider).inset(90)
        }
        
    }
    
    // Creating Slider for change of Music
    func makeMusicSlider(){
        musicSlider = UISlider(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        musicSlider.minMaxValues(min: musicPlayer.minValue, max: musicPlayer.maxValue)
        musicSlider.thumbTintColor = .orange
        musicSlider.minimumTrackTintColor = .blue
        musicSlider.value = Float(storage.loadValueMusic())
        self.addSubview(musicSlider)
        musicSlider.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(30)
            make.top.equalTo(traficSlider).inset(90)
        }
        
    }
    
    // Creating Lable for Character Speed
    func makeCarLable(){
        speedCarLable = UILabel(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        speedCarLable.text = "Скорость монстра"
        self.addSubview(speedCarLable)
        speedCarLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
        }
    }
    // Creating Lable for Trafic Speed
    func makeTraficLable(){
        traficLable = UILabel(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        traficLable.text = "Встречных монстров в секунду"
        self.addSubview(traficLable)
        traficLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(speedCarLable).inset(90)
        }
    }
    
    // Creating Lable for Loud of Music
    func makeMusicLable(){
        musicLable = UILabel(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        musicLable.text = "Громкость музыки"
        self.addSubview(musicLable)
        musicLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(traficLable).inset(90)
        }
    }
    
    func makeBackButton(){
        backButton = UIButton(frame: CGRect(x: 1, y: 1, width: 1, height:1))
        backButton.setTitle("К главному экрану", for: .normal)
        self.addSubview(backButton)
        backButton.backgroundColor = .blue
        backButton.sizeToFit()
        backButton.layer.cornerRadius = 15
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
            make.width.equalTo(250)
        }
        
                        
    }
  
    
}


extension UISlider{
    func minMaxValues(min: Float, max: Float){
        self.minimumValue = min
        self.maximumValue = max
    }
    
}
