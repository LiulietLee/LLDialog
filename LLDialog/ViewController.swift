//
//  ViewController.swift
//  LLDialog
//
//  Created by Liuliet.Lee on 22/1/2016.
//  Copyright © 2016 Liuliet.Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func tappedYesButton() {
        
        label.text = "Accepted"
    }
    
    @objc private func tappedNoButton() {
        
        label.text = "Did not accept"
    }
    
    @IBAction func buttonTapped() {
        
        let dialog = LLDialog()
        
        dialog.title = "Use Google's location service?"
        
        dialog.content = "Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running."
        
        dialog.setYesButton(self, title: "AGREE", action: "tappedYesButton")
        
        dialog.setNoButton(self, title: "DISAGREE", action: "tappedNoButton")
        
        dialog.refreshUI()
        
        self.view.addSubview(dialog)
    }
}

