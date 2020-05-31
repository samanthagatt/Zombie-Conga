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
    
    private var zombie = SKSpriteNode(imageNamed: "zombie1")
    /// How far a zombie should go in one second
    private var zombieMovePointsPerSec: CGFloat = 480.0
    /// The last TimeInterval update(_:) was called
    private var lastUpdate: TimeInterval = 0
    /// Change in time since last time update(_:) was called (how long it's been)
    private var dt: CGFloat = 0
    /// Directional speed of sprite in points/sec to move towards a location
    private var velocity: CGPoint = .zero
    
    // Setup
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "background1")
        // Set anchor point of background to bottom left
        background.anchorPoint = .zero
        // Position it at bottom left of scene
        background.position = .zero
        // Makes sure background is always drawn first
        background.zPosition = -1
        addChild(background)
        
        zombie.position = CGPoint(x: 400, y: 400)
        
        addChild(zombie)
    }
    
    override func update(_ currentTime: TimeInterval) {
        dt = lastUpdate > 0 ? CGFloat(currentTime - lastUpdate) : 0
        lastUpdate = currentTime
        
        move(zombie, velocity: velocity)
    }
    
    /// Move sprite according to time elapsed since last move
    private func move(_ sprite: SKSpriteNode, velocity: CGPoint) {
        let distance = CGPoint(x: velocity.x * dt,
                               y: velocity.y * dt)
        sprite.position = CGPoint(x: sprite.position.x + distance.x,
                                  y: sprite.position.y + distance.y)
        
    }
    
    private func move(_ sprite: SKSpriteNode, toward location: CGPoint) {
        /// Total distance from sprite to location
        let offset = CGPoint(x: location.x - sprite.position.x,
                             y: location.y - sprite.position.y)
        /// Length of `offset` vector using Pythagorean Theorem
        let offsetLength = CGFloat(sqrt(Double(offset.x** + offset.y**)))
        // Normalize the vector so it's a unit vector (has a length of 1)
        let offsetUnit = CGPoint(x: offset.x / offsetLength,
                                 y: offset.y / offsetLength)
        
        velocity = CGPoint(x: offsetUnit.x * zombieMovePointsPerSec,
                               y: offsetUnit.y * zombieMovePointsPerSec)
//        move(sprite, velocity: velocity)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        move(zombie, toward: location)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        move(zombie, toward: location)
    }
}
