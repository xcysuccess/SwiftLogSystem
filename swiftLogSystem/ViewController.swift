//
//  ViewController.swift
//  swiftLogSystem
//
//  Created by tomxiang on 6/14/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        LogInfo(HG300_GUIDE,text: "xiangchenyu")
        LogInfo(HG300_CAMERA,text: "tomxiang")
        LogInfo(HG300_CAMERA,text: "A1")
        LogInfo(HG300_CAMERA,text: "A2")
        LogInfo(HG300_CAMERA,text: "A3")
        
        XXLogger.getFileLogger()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

