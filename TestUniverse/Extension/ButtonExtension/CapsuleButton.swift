//
//  CapsuleButton.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import UIKit

class CapsuleButton: UIButton {
  override func layoutSubviews() {
    super.layoutSubviews()
    let height = bounds.height
    layer.cornerRadius = height/2
  }
}
