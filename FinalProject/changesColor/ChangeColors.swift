//
//  ChangeColors.swift
//  FinalProject
//
//  Created by Ryan on 2023/06/07.
//

import Foundation
import UIKit

class ChangeColors: UIView {

  private var bandColor: UIColor
  typealias SelectedColor = (UIColor) -> Void

  private var SelectedColor: SelectedColor

  init(color: UIColor,frame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50), selectedColor: @escaping SelectedColor ) {

    self.bandColor = color
    self.SelectedColor = selectedColor
    super.init(frame: frame)

    defGestureRecognizer()
  }

  private func defGestureRecognizer() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedAction))
    self.addGestureRecognizer(tapGesture)
  }

  // Band Color Action 넘겨주기!
  @objc func tappedAction(gesture: UITapGestureRecognizer) {
    self.SelectedColor(self.bandColor)

  }

  override func draw(_ rect: CGRect) {
    // 최종 시계의 Object에서 밴드 컬러의 색상을 바꿔주는 펑션
    let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50))
    let layer = CAShapeLayer()
    layer.path = path.cgPath
    layer.fillColor = self.bandColor.cgColor
    self.layer.addSublayer(layer)

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


}
