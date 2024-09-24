//
//  FinishVC.swift
//  Space Ship
//
//  Created by Ivan Pushkov on 25.07.2024.
//

import UIKit
import SnapKit

class FinishController: UIViewController {
    
    var score: Int!
    var maxScore = 0
    var finishhView: FinishView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage.corentResult = score
        setView()
    }
 
    func setView(){
        finishhView = FinishView()
        finishhView.makeFinishView()
        finishhView.repitButton.addTarget(self, action: #selector(repitButtonAction), for: .touchUpInside)
        finishhView.backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        self.view = finishhView
    }
    
    
    
    
    @objc func repitButtonAction(){
        navigationController?.pushViewController(GameController(), animated: true)
        storage.saveScore()
    }
    
   
    @objc func backButtonAction(){
        navigationController?.popToRootViewController(animated: true)
        storage.saveScore()
    }
        
}
  
                              
    


