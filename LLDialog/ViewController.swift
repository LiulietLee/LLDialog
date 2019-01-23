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
            // Set title. (Optional, but recommended)
            .set(title: "Use Google's location service?")

            // Set message. (Optional, but recommended)
            .set(message: "Let Google help apps determine location. This means sending anonymous location data to Google, even when no apps are running.")
            
            // Set the buttons.
            .setPositiveButton(withTitle: "AGREE", target: self, action: #selector(tappedPositiveButton))
            .setNegativeButton(withTitle: "DISAGREE", target: self, action: #selector(tappedNegativeButton))
            
            // At last, show the dialog.
            .show()
    }

    func demonstrateInit() {
        LLDialog.show(LLDialog.init(
            title: "Unapplied method reference",
            message: "It produces better indentation. Maybe not after SE-0042.",
            positiveButton: .init(
                title: "", // Title for positive button is required. "Blank" is the same as "OK".
                onTouchUpInside: (target: self,
                                  action: #selector(tappedPositiveButton))),
            negativeButton: .init(
                title: "What?",
                onTouchUpInside: (target: self,
                                  action: #selector(tappedNegativeButton)))
        ))(/*in: UIApplication.shared.keyWindow*/)
    }
}
