//
//  GameViewController.swift
//  try03 iOS
//
//  Created by Ermiyas Kidane on 17.11.23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameScene = GameScene(size: view.bounds.size)
               let skView = SKView(frame: view.frame)
               skView.presentScene(gameScene)

               view.addSubview(skView)
    }
    
}

