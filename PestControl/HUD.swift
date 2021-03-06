//
//  HUD.swift
//  PestControl
//
//  Created by hs on 2018/12/23.
//  Copyright © 2018年 Ray Wenderlich. All rights reserved.
//

import SpriteKit
enum HUDSettings {
  static let font = "Noteworthy-Bold"
  static let fontSize: CGFloat = 50
}

class HUD: SKNode {
  var timerLabel: SKLabelNode?
  
  override init() {
    super.init()
    name = "HUD" }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    timerLabel = childNode(withName: "Timer") as? SKLabelNode
  }
  
  func add(message: String, position: CGPoint,
           fontSize: CGFloat = HUDSettings.fontSize) {
    let label: SKLabelNode
    label = SKLabelNode(fontNamed: HUDSettings.font)
    label.text = message
    label.name = message
    label.zPosition = 100
    addChild(label)
    label.fontSize = fontSize
    label.position = position
  }
  
  func addTimer(time: Int) {
    guard let scene = scene else { return }
    // 1
    let position = CGPoint(x: 0,
                           y: scene.frame.height/2 - 10)
    add(message: "Timer", position: position, fontSize: 24)
    // 2
    timerLabel = childNode(withName: "Timer") as? SKLabelNode
    timerLabel?.verticalAlignmentMode = .top
    timerLabel?.fontName = "Menlo"
    updateTimer(time: time)
  }
  
  func updateTimer(time: Int) {
    let minutes = (time/60) % 60
    let seconds = time % 60
    let timeText = String(format: "%02d:%02d", minutes, seconds)
    timerLabel?.text = timeText
  }
  
  func updateGameState(from: GameState, to: GameState) {
    clearUI(gameState: from)
    updateUI(gameState: to)
  }
  private func updateUI(gameState: GameState) {
    switch gameState {
    case .win:
      add(message: HUDMessages.win, position: .zero)
      add(message: HUDMessages.nextLevel, position: CGPoint(x: 0, y: -100))
    case .lose:
      add(message: HUDMessages.lose, position: .zero)
      add(message: HUDMessages.playAgain, position: CGPoint(x: 0, y: -100))
    case .start:
      add(message: HUDMessages.tapToStart, position: .zero)
    case .reload:
      add(message: HUDMessages.reload, position: .zero, fontSize: 40)
      add(message: HUDMessages.yes, position: CGPoint(x: -140, y: -100))
      add(message: HUDMessages.no, position: CGPoint(x: 130, y: -100))
    default:
      break
    }
  }
  private func clearUI(gameState: GameState) {
    switch gameState {
    case .win:
      remove(message: HUDMessages.win)
      remove(message: HUDMessages.nextLevel)
    case .lose:
      remove(message: HUDMessages.lose)
      remove(message: HUDMessages.playAgain)
    case .start:
      remove(message: HUDMessages.tapToStart)
    case .reload:
      remove(message: HUDMessages.reload)
      remove(message: HUDMessages.yes)
      remove(message: HUDMessages.no)
    default:
      break
    }
  }
  private func remove(message: String) {
    childNode(withName: message)?.removeFromParent()
  }
  
  
}
