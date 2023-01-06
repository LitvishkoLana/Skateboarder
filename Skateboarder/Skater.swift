//
//  Skater.swift
//  Skateboarder
//
//  Created by Светлана on 5.01.23.
//

import SpriteKit

class Skater: SKSpriteNode {
    
    // MARK: - Public properties
    var velocity = CGPoint.zero
    var minimumY: CGFloat = 0.0
    var jumpSpeed: CGFloat = 20.0
    var isOnGround = true
    
    // MARK: - Public Methods
    func setupPhisicsBody() {
        if let skaterTexture = texture {
            physicsBody = SKPhysicsBody(texture: skaterTexture, size: size)
            physicsBody?.isDynamic = true
            physicsBody?.density = 6.0
            physicsBody?.allowsRotation = false
            physicsBody?.angularDamping = 1.0
            physicsBody?.categoryBitMask = PhysicsCategory.skater
            physicsBody?.collisionBitMask = PhysicsCategory.brick
            physicsBody?.contactTestBitMask = PhysicsCategory.brick | PhysicsCategory.gem
        }
    }
    
    func createSparks() {
        let bundle = Bundle.main
        if let sparksPath = bundle.path(forResource: "Sparks", ofType: "sks") {
            let sparksNode = NSKeyedUnarchiver.unarchiveObject(withFile: sparksPath) as! SKEmitterNode
            sparksNode.position = CGPoint(x: 0.0, y: -50.0)
            addChild(sparksNode)
            
            let waitAction = SKAction.wait(forDuration: 0.5)
            let removeAction = SKAction.removeFromParent()
            let waitThenRemove = SKAction.sequence([waitAction, removeAction])
            sparksNode.run(waitThenRemove)
        }
    }
}
