//
//  ViewController.swift
//  CampusCompanion
//
//  Created by SEAN LIAM BOLOR on 9/12/26.
///Users/sabolor/Desktop/bolormad2/CampusCompanion/CampusCompanion/ViewController.swift

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getStartedTapped(_ sender: UIButton) {
        subtitleLabel.text = "Let's get started!"
    }
    
}

