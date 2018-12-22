//
//  Extensions.swift
//  PestControl
//
//  Created by hs on 2018/12/22.
//  Copyright © 2018年 Ray Wenderlich. All rights reserved.
//

import SpriteKit
extension SKTexture {
  convenience init(pixelImageNamed: String) {
    self.init(imageNamed: pixelImageNamed)
    self.filteringMode = .nearest
  }
}
