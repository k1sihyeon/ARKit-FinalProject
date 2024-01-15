//
//  ViewController.swift
//  FinalProject
//
//  Created by Ryan on 2023/06/01.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

  let registerColor = [UIColor.red, UIColor.cyan, UIColor.systemOrange, UIColor.systemPink]

  private var watchNode: SCNNode!

  private var offsetX: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

      sceneView.autoenablesDefaultLighting = true
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene

        addColorWatch()
    }

  private func addColorWatch() {

    // Loop 함수로 밴드 컬러 등록
    for colors in self.registerColor {
      let watchView = ChangeColors(color: colors) { color in
        print("DEBUG: watchNode failed")
        guard let bandNode = self.watchNode.childNode(withName: "band", recursively: true) else {
          return
        }
        bandNode.geometry?.firstMaterial?.diffuse.contents = color
      }
      self.view.addSubview(watchView)
      configureConstraints(for: watchView)
    }
  }

  // 각 Device에서 Layout을 정해주는 펑션
  private func configureConstraints(for watchView: UIView) {
    watchView.translatesAutoresizingMaskIntoConstraints = false
    //너비
    watchView.widthAnchor.constraint(equalToConstant: watchView.frame.size.width).isActive = true

    //높이
    watchView.heightAnchor.constraint(equalToConstant: watchView.frame.size.height).isActive = true

    //아래 버튼 위치
    watchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -25).isActive = true

    //왼쪽
    watchView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: offsetX).isActive = true

    //버튼 크기 분할
    offsetX += view.frame.width / 4
  }

  
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
      if let anchor = anchor as? ARImageAnchor {
        let refImg = anchor.referenceImage
        addWatch(to: node, referenceImage: refImg)
    }
  }

  // private 함수 - watch 모델 불러오기 및 Node 구성

  private func addWatch(to node: SCNNode, referenceImage: ARReferenceImage) {

    // 데이터 큐에 관한 비동기, 동기 설정
    DispatchQueue.global().async {

      let watchSCN = SCNScene(named: "watch-model.dae")!
      self.watchNode = watchSCN.rootNode.childNode(withName: "watch", recursively: true)!

      node.addChildNode(self.watchNode)
    }
  }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        guard let refImg = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
        fatalError("디텍딩 된 이미지가 없습니다")
      }

      configuration.trackingImages = refImg

        // Run the view's session
      sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}
