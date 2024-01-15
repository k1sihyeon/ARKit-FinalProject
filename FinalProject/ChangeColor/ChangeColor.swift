//
//  ChangeColor.swift
//  FinalProject
//
//  Created by Ryan on 2023/06/07.
//

import Foundation
import UIKit

class ChangeColor: UIView {

  private var bandColor: UIColor
  typealias SelectedColor = (UIColor) -> Void

  private var SelectedColor: SelectedColor

  init(color: UIColor, frame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50), selectedColor: @escaping SelectedColor) {
    self.bandColor = color
    self.SelectedColor = selectedColor
    super.init(frame: frame)

    defGestureRecognizer()

  }

  private func defGestureRecognizer() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedAction))
    self.addGestureRecognizer(tapGesture)
  }

  @objc func tappedAction(recognizer: UITapGestureRecognizer) {
    self.SelectedColor(self.bandColor)
  }

  override func draw(_ rect: CGRect) {
    let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50))
    let layer = CAShapeLayer()
    layer.path = path.cgPath
    layer.fillColor = self.bandColor.cgColor
    
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


}
