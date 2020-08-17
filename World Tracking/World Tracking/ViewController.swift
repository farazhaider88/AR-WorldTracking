//
//  ViewController.swift
//  World Tracking
//
//  Created by Faraz Haider on 17/08/2020.
//  Copyright © 2020 Faraz Haider. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
    }

    @IBAction func addAction(_ sender: Any) {
//        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 0.05))
//        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let node = SCNNode()
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNSphere(radius: 0.1)
//        node.geometry  = SCNTube(innerRadius: 0.1, outerRadius: 0.2, height: 0.3)
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.position = SCNVector3(0.2, 0.3, -0.2)
        boxNode.position = SCNVector3(0,-0.05,0)
        doorNode.position = SCNVector3(0,-0.02,0.055)
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    @IBAction func resetAction(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
    }
    
    func randomNumbers(firstNum : CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum,secondNum)
        
    }
}

