//
//  ViewController.swift
//  SampleDriver
//
//  Created by Pawel Furtek on 12/10/16.
//  Copyright © 2016 Pawel Furtek. All rights reserved.
//

import UIKit
import CallKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dial(_ sender: Any) {
        let handle = CXHandle(type: .generic, value: "Pawel")
        let uuid = UUID()
        (UIApplication.shared.delegate as! AppDelegate).providerDelegate.reportIncomingCall(uuid, handle: handle)
    }

}

