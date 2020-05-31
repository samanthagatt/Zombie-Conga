//
//  GameViewController.swift
//  ZombieConga
//
//  Created by Samantha Gatt on 5/31/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Size of iPad resolution (excluding the 12.9" and 10.5" Pro)
        let size = CGSize(width: 2048, height: 1536)
        let scene = GameScene(size: size)
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        // Scales scene so it fits on device and then cuts off the whatever's outside device frame
        // Will only be scaled _up_ for 12.9" and 10.5" iPad Pro
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
