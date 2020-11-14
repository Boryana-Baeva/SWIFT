//
//  AboutTableViewController.swift
//  BullsЕye
//
//  Created by Veronica Velkova on 18.09.20.
//  Copyright © 2020 softuni-demo. All rights reserved.
//

import UIKit

class AboutTableViewController: UIViewController {
    // MARK: -IBOutlets
    @IBOutlet weak var closeButton: UIButton! {
        didSet{
            closeButton.layer.cornerRadius = 4.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func close() {
        dismiss(animated: true)
    }
}
