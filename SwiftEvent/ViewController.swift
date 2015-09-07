//
//  ViewController.swift
//  SwiftEvent
//
//  Created by Guanshan Liu on 9/6/15.
//  Copyright © 2015 Guanshan Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button.controlEvent.addHandler(self, handler: ViewController.pushNextViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pushNextViewController(eventType: UIControlEvents) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .yellowColor()
        navigationController?.pushViewController(viewController, animated: true)
    }

}

