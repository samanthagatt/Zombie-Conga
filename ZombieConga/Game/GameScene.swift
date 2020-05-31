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
    private var playableRect: CGRect = .zero
    
    override init(size: CGSize) {
        super.init(size: size)
        setupPlayableRect()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlayableRect()
    }
    
    private func setupPlayableRect() {
        /// Largest aspect ratio of Apple devices (iPhone X)
        let maxRatio: CGFloat = 2.16
        let playableHeight = size.width / maxRatio
        let margin = (size.height - playableHeight) / 2
        playableRect = CGRect(x: 0, y: margin, width: size.width, height: playableHeight)
    }
    
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
        
        let shape = SKShapeNode(rect: playableRect)
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4
        addChild(shape)
    }
    
    override func update(_ currentTime: TimeInterval) {
        dt = lastUpdate > 0 ? CGFloat(currentTime - lastUpdate) : 0
        lastUpdate = currentTime
        
        moveZombie()
        boundsCheckZombie()
        rotateZombie()
    }
    
    /// Move zombie according to time elapsed since last move
    private func moveZombie() {
        let distance = CGPoint(x: velocity.x * dt,
                               y: velocity.y * dt)
        zombie.position = CGPoint(x: zombie.position.x + distance.x,
                                  y: zombie.position.y + distance.y)
        
    }
    
    /// Calculates new velocity toward the new location and updates `velocity`
    /// - parameter location: Where you want the zombie to move toward
    private func updateZombieVelocity(toward location: CGPoint) {
        /// Total distance from sprite to location
        let offset = CGPoint(x: location.x - zombie.position.x,
                             y: location.y - zombie.position.y)
        /// Length of `offset` vector using Pythagorean Theorem
        let offsetLength = CGFloat(sqrt(Double(offset.x** + offset.y**)))
        // Normalize the vector so it's a unit vector (has a length of 1)
        let offsetUnit = CGPoint(x: offset.x / offsetLength,
                                 y: offset.y / offsetLength)
        
        velocity = CGPoint(x: offsetUnit.x * zombieMovePointsPerSec,
                               y: offsetUnit.y * zombieMovePointsPerSec)
    }
    private func boundsCheckZombie() {
        let bottomLeft: CGPoint = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        // If zombie is out of bounds on the left
        if zombie.position.x <= bottomLeft.x {
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        // If zombie is out of bounds on the right
        if zombie.position.x >= topRight.x {
            zombie.position.x = topRight.x
            velocity.x = -velocity.x
        }
        // If zombie is out of bounds on the bottom
        if zombie.position.y <= bottomLeft.y {
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        // If zombie is out of bounds on the top
        if zombie.position.y >= topRight.y {
            zombie.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    private func rotateZombie() {
        // calculates arctan of (velocity.y / velocity.x)
        zombie.zRotation = atan2(velocity.y, velocity.x)
        // Don't have to rotate it any more since zombie faces the left (0°)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        updateZombieVelocity(toward: location)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        updateZombieVelocity(toward: location)
    }
}
