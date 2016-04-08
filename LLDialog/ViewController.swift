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
    
    @objc private func tappedPositiveButton() {
        
        label.text = "Accepted"
    }
    
    @objc private func tappedNegativeButton() {
        
        label.text = "Did not accept"
    }
    
    @IBAction func buttonTapped() {
        
        let dialog = LLDialog()
        
        dialog.title = "Use Google's location service?"
        
        dialog.message = "Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running."
        
        dialog.setPositiveButton(title: "AGREE", target: self, action: #selector(tappedPositiveButton))
        dialog.setNegativeButton(title: "DISAGREE", target: self,  action: #selector(tappedNegativeButton))
        
        dialog.show()
        
    }
}

