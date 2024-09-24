//
//  GameScene.swift
//  Space Ship
//
//  Created by Ivan Pushkov on 10.07.2024.
//
import Foundation
import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate{
    
   //Объявляем объекты
    var car = SKSpriteNode()
    var carLayer: SKSpriteNode!
    var roadBackGround: SKSpriteNode!
    

    var scoreLable: SKLabelNode!
    var threatLayer: SKSpriteNode!
    
    var game = Game()
    
    
   
    
   
    // Создаем категории
    let carCategory: UInt32 = 0x01 << 0
    let threatCategory: UInt32 = 0x1 << 1
    
    var gameIsPouse = true
    var soundIsOn = true
    
    
    var defeatDelegate: DefeatDelegateProtocol!
    
    
    
    func pauseTheGame(){
        gameIsPouse = true
        self.threatLayer.isPaused = true
        physicsWorld.speed = 0
        removeAction(forKey: "repit")
    }
    
    func unPauseTheGame(){
        gameIsPouse = false
        self.threatLayer.isPaused  = false
        physicsWorld.speed = 1
        self.run(self.uncomminTrafic(), withKey: "repit")
       
       
    }
    func resetTheGame(){
        
        scoreLable.text = "Score: \(game.score)"
        unPauseTheGame()
    }
    
    
    func pouseAction(){
        switch gameIsPouse{
        case true: unPauseTheGame()
        case false: pauseTheGame()
        }
        
    }
    
    // функция которая вызываетвстречную угрозу
    func uncomminTrafic() -> SKAction{
        // падение кубиков
        let threatCreateAction = SKAction.run {
            
            let threat = self.makeThreat()
            self.threatLayer.addChild(threat)
        }
        let threatPerSec = storage.loadSpeedTrafic()
        let threatWaitingCreating  = SKAction.wait(forDuration: 1.0 / Double(threatPerSec), withRange: 1)
        let threatSequenceAction = SKAction.sequence([threatCreateAction, threatWaitingCreating])
        let repeated = SKAction.repeatForever(threatSequenceAction)
        let repeating = SKAction.sequence([repeated, threatWaitingCreating])
        return repeating
    }
    
    
   
    

    //MARK: - Загрузка экрана
    override func didMove(to view: SKView) {
       
        physicsWorld.contactDelegate = self
        physicsWorld.gravity.dy = -7.0
        makeBackGround()
        makeCar()
        threatLayer = SKSpriteNode()
        self.addChild(self.threatLayer)
      
        let rapiating = uncomminTrafic()
         run(rapiating, withKey: "repit")
        // текст
        scoreLable = SKLabelNode(text: "Score: \(game.score)")
        scoreLable.position = CGPoint(x: (0), y: frame.height / 2 - scoreLable.frame.size.height - 100 )
        scoreLable.inputView?.sizeToFit()
        scoreLable.xScale = 1.5
        scoreLable.yScale = 1.5
        scoreLable.zPosition = 1
        scoreLable.color = .white
        addChild(scoreLable)
        
    }
    
 
    
   //MARK: - Начало прикосновения
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameIsPouse{
            if let touch = touches.first{
                let positionTouch = touch.location(in: self)
                let distance = knowDistance(a: carLayer.position, b: positionTouch)
                let speed = storage.loadSpeedCar() 
                let time: TimeInterval = distance / speed
                let action  = SKAction.move(to: positionTouch, duration: time)
                carLayer.run(action)
                let bgAction  = SKAction.move(to: CGPoint(x: positionTouch.x / 10, y: positionTouch.y / 10), duration: 1)
                roadBackGround.run(bgAction)
                
            }
        }
    }
    
    func knowDistance(a: CGPoint, b: CGPoint) -> Double{
        let distance = sqrt(pow((b.x - a.x),2) + pow((b.y - a.y),2))
            return distance
    }
    
  
    //MARK: - переопределяем метод при создании физического тела
    override func didSimulatePhysics() {
        threatLayer.enumerateChildNodes(withName: "Threat", using: {(threat, stop) in
            let hightScreen  = self.frame.height
            if threat.position.y < -hightScreen{
                self.game.addPoint()
                self.scoreLable.text = self.game.showCorentScore()
                threat.removeFromParent()
            }
        })
    }
    
    //MARK:  - Методы для создания объектов и их экшенов
    
    
    
    func makeBackGround(){
        roadBackGround = SKSpriteNode(imageNamed: "PausePhone", normalMapped: true)
        roadBackGround.zPosition = -1
        roadBackGround.position = CGPoint(x: 0, y: 0)
        addChild(roadBackGround)
        
    }
    
    //MARK: - Make Car
    func makeCar(){
        car = SKSpriteNode(imageNamed: "Персонаж", normalMapped: true)
        car.xScale = 0.15
        car.yScale = 0.15
      //  car.zRotation = .pi / 1
        car.zPosition = 2
        
        car.physicsBody?.isDynamic = false
        car.physicsBody = SKPhysicsBody(texture: car.texture!, size: car.size)
        car.physicsBody?.isDynamic = false
        car.physicsBody?.categoryBitMask = carCategory
        car.physicsBody?.contactTestBitMask = threatCategory
        car.physicsBody?.collisionBitMask = threatCategory
       
        
        
        let nitro = SKEmitterNode(fileNamed: "bubble")
        nitro?.position.x = car.position.x
        nitro?.position.y  = car.position.y - car.size.height / 2
        nitro?.particleSize = CGSize(width: car.size.width / 4, height: car.size.height / 2 )
        nitro?.targetNode = self
        carLayer = SKSpriteNode()
        car.position = CGPoint(x: 0, y: frame.minY + car.size.height)
        
        carLayer.addChild(car)
        car.position.y = 0
        car.position.x = 0
        carLayer.addChild(nitro!)
        addChild(carLayer)
    }
    func makeThreat() -> SKSpriteNode {
        
        let threat = SKSpriteNode(imageNamed: "Монстрик", normalMapped: true)
        threat.name =  "Threat"
        let halfWith = frame.width / 2
        threat.xScale = 0.4
        threat.yScale = 0.4
        threat.position.x = CGFloat.random(in: -halfWith...halfWith)
        threat.position.y = frame.maxY
        threat.physicsBody = SKPhysicsBody(texture: threat.texture! , size: threat.size)
        threat.physicsBody?.affectedByGravity = true
        let threatSpeedX = 100.0
        threat.physicsBody?.velocity.dx = CGFloat(drand48() * 2 - 1) * threatSpeedX
        threat.physicsBody?.categoryBitMask = threatCategory
        threat.physicsBody?.collisionBitMask = carCategory
        threat.physicsBody?.contactTestBitMask = carCategory
        
        return threat
    }
    
    
    var accidentHappend = false
    
    func didBegin(_ contact: SKPhysicsContact){
       
        if contact.bodyA.categoryBitMask == carCategory && contact.bodyB.categoryBitMask == threatCategory && accidentHappend == false
        {
            accidentHappend = true
           
            self.scoreLable.text = game.showCorentScore()
            let yelowColorAction =  SKAction.colorize(with: .yellow, colorBlendFactor: 1, duration: 0.2)
            let redColorAction = SKAction.colorize(with: .red, colorBlendFactor: 0, duration: 0.6)
            let seqenceColorAction = SKAction.sequence([yelowColorAction, redColorAction])
            let repiatingChangeColor = SKAction.repeat(seqenceColorAction, count: 2)
            car.run(repiatingChangeColor)
            gameStop()
            if soundIsOn {
                let soundAction = SKAction.playSoundFileNamed("Hit", waitForCompletion: true)
                run(soundAction)
            }
        }
    }
    
    
    func gameStop(){
      //  self.removeAllChildren()
        pouseAction()
        let finishVC = FinishController()
        finishVC.score = game.score
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.makeSmile()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                self.makeEyes()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                self.defeatDelegate.defeatAction(viewController: finishVC)

        }
        
    }
    
    func makeSmile(){
        let smileNode = SKSpriteNode(imageNamed: "Smile")
        smileNode.xScale = 0.15
        smileNode.yScale = 0.15
        carLayer.addChild(smileNode)
        smileNode.zPosition = 3
    }
    func makeEyes(){
        let smileNode = SKSpriteNode(imageNamed: "Eyes")
        smileNode.xScale = 0.15
        smileNode.yScale = 0.15
        carLayer.addChild(smileNode)
        smileNode.zPosition = 3
    }
    
}




 
