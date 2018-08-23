//
//  ViewController.swift
//  LLDialog
//
//  Created by Liuliet.Lee on 22/1/2016.
//  Copyright © 2016-2017 Liuliet.Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    @objc private func tappedPositiveButton() {
        label.text = "Accepted"
    }

    @objc private func tappedNegativeButton() {
        label.text = "Did not accept"
    }

    @IBAction func buttonTapped() {
        LLDialog()
            // Set title. (Not required)
            .set(title: "Use Google's location service?")
        
            // Set message. (Not required)
            .set(message: "Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running.")
            
            // Set the buttons.
            // Title for positive button is required. If set it to be a "blank" string, it will automatically change to "OK"
            .setPositiveButton(withTitle: "AGREE", target: self, action: #selector(tappedPositiveButton))
            .setNegativeButton(withTitle: "DISAGREE", target: self, action: #selector(tappedNegativeButton))
            
            // At last, show the dialog.
            .show()
    }
}

