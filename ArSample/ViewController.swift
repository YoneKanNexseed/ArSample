//
//  ViewController.swift
//  ArSample
//
//  Created by yonekan on 2018/09/19.
//  Copyright © 2018年 yonekan. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .slide }

    @IBOutlet weak var arSceneView: ARSCNView!
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        guard let currentFrame = arSceneView.session.currentFrame else { return  }
        
        let viewWidth  = arSceneView.bounds.width
        let viewHeight = arSceneView.bounds.height
        let imagePlane = SCNPlane(width: viewWidth/6000, height: viewHeight/6000)
        imagePlane.firstMaterial?.diffuse.contents = arSceneView.snapshot()
        imagePlane.firstMaterial?.lightingModel = .constant
        
        let planeNode = SCNNode(geometry: imagePlane)
        arSceneView.scene.rootNode.addChildNode(planeNode)
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.1
        planeNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let mySession = ARSession()
//        arSceneView.session = mySession
//
//        arSceneView.showsStatistics = true
//
//        arSceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        let scene = SCNScene()
        arSceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        arSceneView.session.run(configuration, options: .resetTracking)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let configuration = ARWorldTrackingConfiguration()
        
        arSceneView.session.run(configuration, options: .resetTracking)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        arSceneView.session.pause()
    }
}

