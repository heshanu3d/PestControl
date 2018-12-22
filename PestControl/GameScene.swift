import SpriteKit

class GameScene: SKScene {
  var background: SKTileMapNode!
  var player = Player()
  var bugsNode = SKNode()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    background = childNode(withName: "background") as! SKTileMapNode
  }
  override func didMove(to view: SKView) {
    addChild(player)
    
//    let bug = Bug()
//    bug.position = CGPoint(x: 60, y: 0)
//    addChild(bug)
    
    setupCamera()
    setupWorldPhysics()
    createBugs()
  }
  
  func setupCamera() {
    guard let camera = camera, let view = view else { return }
    let zeroDistance = SKRange(constantValue: 0)
    let playerConstraint = SKConstraint.distance(zeroDistance,
                                                 // 1
      to: player)
    let xInset = min(view.bounds.width/2 * camera.xScale,
                     background.frame.width/2)
    let yInset = min(view.bounds.height/2 * camera.yScale,
                     background.frame.height/2)
    // 2
    let constraintRect = background.frame.insetBy(dx: xInset, dy: yInset)
    let xRange = SKRange(lowerLimit: constraintRect.minX,
                         upperLimit: constraintRect.maxX)
    let yRange = SKRange(lowerLimit: constraintRect.minY,
                         upperLimit: constraintRect.maxY)
    let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
//    edgeConstraint.referenceNode = background
    // 4
    camera.constraints = [playerConstraint, edgeConstraint]

  }
  
  func setupWorldPhysics() {
    background.physicsBody = SKPhysicsBody(edgeLoopFrom: background.frame)
  }
  
  func tile(in tileMap: SKTileMapNode, at coordinates: TileCoordinates) -> SKTileDefinition? {
      return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
  }
  
  func createBugs() {
    guard let bugsMap = childNode(withName: "bugs") as? SKTileMapNode else { return }
    // 1
    for row in 0..<bugsMap.numberOfRows {
      for column in 0..<bugsMap.numberOfColumns {
        // 2
        guard let tile = tile(in: bugsMap, at: (column, row)) else { continue }
          // 3
        let bug = Bug()
        bug.position = bugsMap.centerOfTile(atColumn: column, row: row)
        bugsNode.addChild(bug)
        bug.move()
      }
    }
    // 4
    bugsNode.name = "Bugs"
    addChild(bugsNode)
//    bugsNode.enumerateChildNodes(withName: "bug", using: {node, _ in
//      node.isPaused = false
//    })

    // 5
    bugsMap.removeFromParent()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    let touch = touches.first
    if touch != nil {
      player.move(target: touch!.location(in: self))
    }
  }
  
}

