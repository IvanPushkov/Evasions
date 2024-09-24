//
//  FinishView.swift
//  Evasions
//
//  Created by Ivan Pushkov on 23.09.2024.
//

import UIKit

class FinishView: UIView{
    
    var maxScoreLable: UILabel!
    var corentScoreLable: UILabel!
    
    var repitButton  = UIButton()
    var backButton = UIButton()
   
    let lableFont = UIFont(name: "System", size: 45)
    
    func makeFinishView(){
        self.backgroundColor = UIColor(patternImage: UIImage(named: "StartBackgroundImage")!)
        makeCurentScore()
        makeRepitButton()
        mackeBackButton()
        makeMaxScore()
    }
    
    func makeRepitButton(){
        repitButton = UIButton(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
        repitButton.setTitle("Повторить", for: .normal)
        self.addSubview(repitButton)
        repitButton.backgroundColor = .blue
        repitButton.sizeToFit()
       
        repitButton.layer.cornerRadius = 15
        repitButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(200)
            make.width.equalTo(150)
            
            
        }
        
        
        
    }
    
    func mackeBackButton(){
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
    
     
     
     func makeMaxScore(){
         maxScoreLable = UILabel(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
         maxScoreLable.text = "Record is \(storage.loadScore())"
         maxScoreLable.font = lableFont
         self.addSubview(maxScoreLable)
         maxScoreLable.snp.makeConstraints { make in
             make.centerX.equalToSuperview()
             make.top.equalToSuperview().inset(60)
         }
     }
     
     func makeCurentScore(){
         corentScoreLable = UILabel(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
         corentScoreLable.text = "Corent resolt is \(storage.corentResult)"
         corentScoreLable.font = lableFont
         self.addSubview(corentScoreLable)
         corentScoreLable.snp.makeConstraints { make in
             make.centerX.equalTo(self)
             make.centerY.equalToSuperview().inset(30)
         }
          
     }
    
    
}
