//
//  LLDialog.swift
//  LLDialog
//
//  Created by Liuliet.Lee on 22/1/2016.
//  Copyright © 2016 Liuliet.Lee. All rights reserved.
//

import UIKit

class LLDialog: UIView {

    // MARK: Properties

    /// Title of LLDialog
    var title: String? = "Title"
    /// Message of LLDialog
    var message: String? = "This is the message."

    private var negativeButton = UIButton()
    private var positiveButton = UIButton()
    private var titleLabel = UILabel()
    private var contentLabel = UILabel()
    private var cover = UIView()
    private var negativeText: String?
    private var positiveText = "OK"

    // MARK: Supports
    private var screenSize: CGSize{
        get{
            return UIScreen.main.bounds.size
        }
    }

    // MARK: View did load
    override func draw(_ rect: CGRect) {

        cover.alpha = 0.0
        cover.frame = CGRect(origin: .zero, size: screenSize)
        cover.backgroundColor = UIColor.black

        let currentWindow = UIApplication.shared.keyWindow
        currentWindow?.addSubview(cover)
        currentWindow?.addSubview(self)

        self.superview!.bringSubview(toFront: self)
        self.alpha = 0.0

        UIView.animate(withDuration: 0.3) { self.cover.alpha = 0.6 }
        UIView.animate(withDuration: 0.3) { self.alpha = 1.0 }
    }

    /// Add shadow to the view.
    override func layoutSubviews() {
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 2).cgPath
    }

    // MARK: Configure controls

    /**
     Refresh all controls, show dialog, add observer to handle rotation

     - parameter superview: The view that will become the superview of LLDialog. Set to be `keyWindow` by default.
     */
    func show(inView possibleHost: UIView? = UIApplication.shared.keyWindow){
        self.contentMode = .redraw
        NotificationCenter.default.addObserver(self, selector: #selector(LLDialog.placeControls), name: .UIDeviceOrientationDidChange, object: nil)
        addControls()
        placeControls()
        if let host = possibleHost{
            host.addSubview(self)
        }
    }

    /**
     To configure labels

     - parameter label:         The label to configure
     - parameter text:          The text that will be displayed
     - parameter preferedFont:  Prefered font. If nil, will use the default font
     - parameter size:          Size of text
     - parameter preferedColor: Prefered color. If nil, will use the default color
     */
    private func configure(_ label: inout UILabel, withText text: String? = nil, font preferedFont: String? = nil, fontSize size: CGFloat, textColor preferedColor: UIColor? = nil){
        label.text = text
        if let font = preferedFont{
            label.font = UIFont(name: font, size: size)
        }
        if let color = preferedColor{
            label.textColor = color
        }
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
    }

    /**
     To configure button

     - parameter button: The button to configure
     - parameter title:  The text that will be displayed
     */
    private func configure(_ button: inout UIButton, withTitle title: String? = nil){
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor(red:0.07, green:0.58, blue:0.96, alpha:1), for: UIControlState())
        button.titleLabel?.font = button.titleLabel?.font.withSize(16)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
        button.sizeToFit()
        button.addTarget(self, action: #selector(LLDialog.disappear), for: .touchUpInside)
    }

    /// Configure controls and add them to the view
    private func addControls() {

        configure(&titleLabel, withText: title, font: "HelveticaNeue-Medium", fontSize: 18)
        configure(&contentLabel, withText: message, fontSize: 16, textColor: UIColor(red:0.49, green:0.49, blue:0.49, alpha:1))

        configure(&negativeButton, withTitle: negativeText)
        configure(&positiveButton, withTitle: positiveText)

        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(negativeButton)
        addSubview(positiveButton)
    }

    /**
     Set the label frame

     - parameter label:  The label to place
     - parameter width:  The width avalialbe
     - parameter y: Y position
     */
    private func place(label: inout UILabel, width: CGFloat, y: CGFloat) {
        label.frame = CGRect(x: 24, y: 0, width: width - 48, height: .greatestFiniteMagnitude)
        label.sizeToFit()
        label.frame.origin.y = y
    }

    /**
     Set the button frame

     - parameter button: The button to place
     - parameter x:      X position
     - parameter y:      Y position
     */
    private func place(button: inout UIButton, x: CGFloat, y: CGFloat){
        let width = button.frame.width
        let height : CGFloat = 36
        button.frame = CGRect(x: x, y: y, width: width, height: height)
    }

    /// Place all controls to correct position.
    @objc private func placeControls() {

        let width = screenSize.width * (7 / 9)

        place(label: &titleLabel, width: width, y: 24)
        let titleLabelHeight = titleLabel.frame.height

        place(label: &contentLabel, width: width, y: 24 + titleLabelHeight + 20)
        let contentLabelHeight = contentLabel.frame.height

        let viewHeight = 24 + titleLabelHeight + 20 + contentLabelHeight + 32 + 36 + 8
        let viewSize = CGSize(width: width, height: viewHeight)

//        let screenBounds = UIScreen.main().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let viewPoint = CGPoint(x: (1 / 9) * screenWidth, y: screenHeight / 2 - CGFloat(viewHeight) / 2)
        self.frame = CGRect(origin: viewPoint, size: viewSize)
        self.backgroundColor = UIColor.white

        let buttonY = viewHeight - 8 - 36
        let positiveButtonWidth = positiveButton.frame.width
        let positiveButtonX = width - 8 - positiveButtonWidth
        let negativeButtonWidth = negativeButton.frame.width
        place(button: &positiveButton, x: positiveButtonX, y: buttonY)
        place(button: &negativeButton, x: positiveButtonX - 8 - negativeButtonWidth, y: buttonY)
    }

    // MARK: Button actions

    /**
     Function about configuring positiveButton

     - parameters:
     - title: Title of positive button
     - target: The target object—that is, the object whose action method is called. Set to be nil by default, which means UIKit searches the responder chain for an object that responds to the specified action message and delivers the message to that object.
     - action: A selector identifying the action method to be called. Set to be nil by dafault, which means after taping the button, the LLDialog view disappears.
     */
    func setPositiveButton(withTitle title: String, target: AnyObject? = nil,  action possibleFunction: Selector? = nil){
        if !title.isBlank{
            positiveText = title
        }
        if let function = possibleFunction{
            positiveButton.addTarget(target, action: function, for: .touchUpInside)
        }
    }


    /**
     Function about configuring negativeButton

     - parameter title:    Title of negative button
     - parameter target:   The target object—that is, the object whose action method is called. Set to be nil by default, which means UIKit searches the responder chain for an object that responds to the specified action message and delivers the message to that object.
     - parameter function: A selector identifying the action method to be called. Set to be nil by dafault, which means after taping the button, the LLDialog view disappears.
     */
    func setNegativeButton(withTitle title: String? = nil, target: AnyObject? = nil, action possibleFunction: Selector? = nil){
        negativeText = title
        if let function = possibleFunction{
            negativeButton.addTarget(target, action: function, for: .touchUpInside)
        }
    }

    /// Disapper the view when tapped button, remove observer
    @objc private func disappear() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
            self.cover.alpha = 0.0
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            self.cover.removeFromSuperview()
            self.removeFromSuperview()
        }
        
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
    }
}

extension String {
    /// To check if the string contains characters other than white space and \n
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
}
