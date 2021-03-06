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
    
    private var zombie: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "zombie1")
        node.position = CGPoint(x: 400, y: 400)
        return node
    }()
    /// How far a zombie should go (in points) after one second
    private var zombieMovePointsPerSec: CGFloat = 480.0
    /// How far a zombie should rotate (in radians) after one second
    private var zombieRotationRadsPerSec: CGFloat = .pi*4
    /// The last TimeInterval update(_:) was called
    private var lastUpdate: TimeInterval = 0
    /// Change in time since last time update(_:) was called (how long it's been in seconds)
    private var dt: CGFloat = 0
    /// Directional speed of sprite in points/sec to move towards a location
    private var velocity: CGPoint = .zero
    /// The rect where the zombie can move
    private lazy var playableRect: CGRect = {
        /// Highest ratio of Apple devices (iPhone X and up)
        let maxRatio: CGFloat = 2.16
        let playableHeight = size.width / maxRatio
        let margin = (size.height - playableHeight) / 2
        return CGRect(x: 0, y: margin, width: size.width, height: playableHeight)
    }()
    
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
        
        let shape = SKShapeNode(rect: playableRect)
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4
        
        let nodes: [SKNode] = [background, zombie, shape]
        for child in nodes {
            addChild(child)
        }
        
        spawnEnemy()
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
        let distance = velocity * dt
        zombie.position += distance
    }
    
    /// Calculates new velocity toward the new location and updates `velocity`
    /// - parameter location: Where you want the zombie to move toward
    private func updateZombieVelocity(toward location: CGPoint) {
        /// Total distance from sprite to location
        let offset = location - zombie.position
        velocity = offset.unitVector * zombieMovePointsPerSec
    }
    /// Calculates new velocity toward the first touch and updates `velocity`
    /// - note: Uses `updateZombieVelocity(toward location:)`
    /// - parameter touches: The set of user touches. Only the first touch will be used.
    private func updateZombieVelocity(on touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        updateZombieVelocity(toward: location)
    }
    /// Makes sure zombie isn't out of bounds, and bounces him off the edge if he is
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
    /// Rotates zombie so he's facing the correct direction
    ///
    /// Mostly it works but sometimes the shortest angle makes him go backwards
    /// (I've only seen it happen when he bounces off the bottom playable edge).
    /// Also one time I saw it spin in a circle (way less frequent than going backwards)
    /// Once I changed | prefix operator from using magnitude and then converting it back
    /// into its original type, to instead using abs(_:), I haven't seen any bugs
    private func rotateZombie() {
        let shortest = zombie.zRotation.shortestAngle(to: velocity.angle)
        var radsToRotate = zombieRotationRadsPerSec * dt
        if |shortest| < radsToRotate {
            radsToRotate = |shortest|
        }
        radsToRotate = shortest.isNegative ? -radsToRotate : radsToRotate
        zombie.zRotation += radsToRotate
    }
    
    private func spawnEnemy() {
        let enemy = SKSpriteNode(imageNamed: "enemy")
        let halfEnemyWidth = enemy.size.width / 2
        let halfEnemyHeight = enemy.size.height / 2
        enemy.position = CGPoint(x: size.width + halfEnemyWidth,
                                 y: size.height / 2)
        addChild(enemy)
        /// Front of enemy (left side) is at middle of sceen and
        /// body of enemy is at bottom of playable area
        let midLocation = CGPoint(x: size.width / 2 + halfEnemyWidth,
                                  y: playableRect.minY + halfEnemyHeight)
        let midMoveAction: SKAction = .move(to: midLocation, duration: 1)
        let endLocation = CGPoint(x: -halfEnemyWidth, y: enemy.position.y)
        let moveAction: SKAction = .move(to: endLocation, duration: 1)
        let log: SKAction = .run { print("Reached bottom!") }
        let wait: SKAction = .wait(forDuration: 0.25)
        let sequence: SKAction = .sequence([midMoveAction, log, wait, moveAction])
        enemy.run(sequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateZombieVelocity(on: touches)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateZombieVelocity(on: touches)
    }
}
