//
//  GameScene.swift
//  try03 Shared
//
//  Created by Ermiyas Kidane on 17.11.23.
//

import SpriteKit
import GameKit

class GameScene: SKScene {
    
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    
    
    var touchBall: Bool = false
    var ball: SKShapeNode!
    var circle: SKShapeNode!
    var cameraNode = SKCameraNode()
    var player: SKSpriteNode!
    
    
    
    
    
    

    override func didMove(to view: SKView) {
        
        createJoyStick()
        createPlayer()
      
    }
    
  
    

    func createPlayer() {
        player = SKSpriteNode(texture: SKTexture(imageNamed: "3d4550f9af824a3ff7f321cfb239afa73j0UNtUWzxMkHPRM-0"))
        player.position = CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.3)
        addChild(player)
        addChild(cameraNode)
        camera = cameraNode
    }
    
    func playerAnimation(){
        var arrayTexture:[SKTexture] = []
        for i in 0...12{
            let texture = SKTexture(imageNamed:"3d4550f9af824a3ff7f321cfb239afa73j0UNtUWzxMkHPRM-\(i)")
            arrayTexture.append(texture)
        }
        let animationRun = SKAction.animate(with: arrayTexture, timePerFrame: 0.09)
        let repeatRun = SKAction.repeatForever(animationRun)
        player.run(repeatRun )
        
    }
    
    
    
    

    func createJoyStick() {
        ball = SKShapeNode(circleOfRadius: 40)
        ball.name = "ball"
        ball.zPosition = 2
        ball.position = CGPoint(x:-self.size.width*0.3,y:-size.height*0.2)
        ball.fillColor = .white
        ball.strokeColor = .white
        cameraNode.addChild(ball)

        circle = SKShapeNode(circleOfRadius: 90)
        circle.fillColor = .clear
        circle.strokeColor = .white
        circle.lineWidth = 5
        circle.position = ball.position
        cameraNode.addChild(circle)
        
        
    }
    
    //Wall func
    
    func wallCheck(){
        let bottomLeft = CGPoint(x:-850, y:-480)
        let topRight = CGPoint(x:780,y:600)
    
        if player.position.x  <= bottomLeft.x{
            player.position.x  = bottomLeft.x
        }
        if player.position.x >= topRight.x{
            player.position.x = topRight.x
        }
        if player.position.y  <= bottomLeft.y{
            player.position.y  = bottomLeft.y
        }
        if player.position.y >= topRight.y{
            player.position.y = topRight.y
        }
    }
    
    
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch!.location(in: self)
        
        print("touchesBegan at location: \(location)")
        
        
        if atPoint(location).name == "ball" {
            print("touch ball")
           
            touchBall = true
            playerAnimation()
        }
    }
    
    
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touchesMoved")
        guard touchBall else { return }
        
        let touch = touches.first
        let location = touch!.location(in: self)
        let convertLocation = self.convert(location, to: cameraNode)
        
        print("touch location: \(location)")
        print("converted location: \(convertLocation)")
        
        if touchBall{
            let dx = convertLocation.x - circle.position.x
            let dy = convertLocation.y - circle.position.y
            let angle = atan2(dy,dx)
            // Setze die Position des Balls auf die neue konvertierte Position
            ball.position = convertLocation
            
            let square = sqrt(dx*dx + dy*dy)
            
            if ball.position.x > circle.position.x{
                player.xScale = 1
            }
            else if ball.position.x < circle.position.x{
                player.xScale = -1
            }
            
            if square >= 100 {
                ball.position = CGPoint(x: cos(angle)*50 + circle.position.x, y: sin(angle)*50 + circle.position.y)
            }
            else {
                ball.position = convertLocation
            }
        }
        
        
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        ball.position = circle.position
        touchBall = false
        player.removeAllActions()
    }
    
    

    override func update(_ currentTime: TimeInterval) {
        
        if touchBall {
            let dx = ball.position.x - circle.position.x
            let dy = ball.position.y - circle.position.y
            let angle = atan2(dy,dx)
            
            player.position = CGPoint(x: cos(angle)*5 + player.position.x, y: sin(angle)*5 + player.position.y)
            cameraNode.position = player.position
            wallCheck()
        }
        
        
    }
}



