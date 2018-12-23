//
//  Types.swift
//  PestControl
//
//  Created by hs on 2018/12/22.
//  Copyright © 2018年 Ray Wenderlich. All rights reserved.
//

enum Direction: Int {
  case forward = 0, backward, left, right
}

typealias TileCoordinates = (column: Int, row: Int)

struct PhysicsCategory {
  static let None:      UInt32 = 0
  static let All:       UInt32 = 0xFFFFFFFF
  static let Edge:      UInt32 = 0b1
  static let Player:    UInt32 = 0b10
  static let Bug:       UInt32 = 0b100
  static let Firebug:   UInt32 = 0b1000
  static let Breakable: UInt32 = 0b10000
}

enum HUDMessages {
  static let tapToStart = "Tap to Start"
  static let win = "You Win!"
  static let lose = "Out of Time!"
  static let nextLevel = "Tap for Next Level"
  static let playAgain = "Tap to Play Again"
  static let reload = "Continue Previous Game?"
  static let yes = "Yes"
  static let no = "No"
}

enum GameState: Int {
  case initial=0, start, play, win, lose, reload, pause
}
