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
