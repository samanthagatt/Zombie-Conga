//
//  GameScene.swift
//  ZombieConga
//
//  Created by Samantha Gatt on 5/31/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var zombie = SKSpriteNode(imageNamed: "zombie1")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "background1")
        // 0,0 is bottom left unlike UIKit which is top left
        // SK automatically places children to be centered at 0,0
        // `background.position = CGPoint(x: size.width/2, y: size.height/2)`
        // Same as:
        // Set anchor point of background to bottom left
        background.anchorPoint = .zero
        // Position it at bottom left of scene
        background.position = .zero
        // Makes sure background is always drawn first
        background.zPosition = -1
        addChild(background)
        
        zombie.position = CGPoint(x: 400, y: 400)
        zombie.setScale(2)
        addChild(zombie)
    }
}
