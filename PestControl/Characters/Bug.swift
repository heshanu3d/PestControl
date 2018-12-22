//
//  Bug.swift
//  PestControl
//
//  Created by hs on 2018/12/22.
//  Copyright © 2018年 Ray Wenderlich. All rights reserved.
//

import SpriteKit

enum BugSettings {
  static let bugDistance: CGFloat = 16
}


class Bug: SKSpriteNode {
  var animations: [SKAction] = []
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("Use init()")
  }
  
  init(){
    let texture = SKTexture(imageNamed: "bug_ft1")
    super.init(texture: texture, color: .white, size: texture.size())
//    name = "bug"
    physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
    physicsBody!.restitution = 0.5
    physicsBody!.allowsRotation = false
    createAnimations(character: "bug")
  }
  
  func move() {
    // 1
    let randomX = CGFloat(Int.random(min: -1, max: 1))
    let randomY = CGFloat(Int.random(min: -1, max: 1))
    let vector = CGVector(dx: randomX * BugSettings.bugDistance,
                          dy: randomY * BugSettings.bugDistance)
    let moveBy = SKAction.move(by: vector, duration: 1)
    let moveAgain = SKAction.run(move)
    
    let direction = animationDirection(for: vector)
    // 2
    if direction == .left {
      xScale = abs(xScale)
    } else if direction == .right {
      xScale = -abs(xScale)
    }
    // 3
    run(animations[direction.rawValue], withKey: "animation")
    run(SKAction.sequence([moveBy, moveAgain]))
  }
}


extension Bug : Animatable {}
