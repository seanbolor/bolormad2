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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notifySwitch: UISwitch!
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getStartedTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowDetailSegue", sender: self)
    }
    
}

