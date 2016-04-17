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

    // MARK: View did load

    override func drawRect(rect: CGRect) {

        let frame = UIScreen.mainScreen().bounds.size

        cover.alpha = 0.0
        cover.frame = CGRect(origin: CGPointZero, size: frame)
        cover.backgroundColor = UIColor.blackColor()

        let currentWindow = UIApplication.sharedApplication().keyWindow
        currentWindow?.addSubview(cover)
        currentWindow?.addSubview(self)

        self.superview!.bringSubviewToFront(self)
        self.alpha = 0.0

        UIView.animateWithDuration(0.3) { () -> Void in
            self.cover.alpha = 0.6
        }
        UIView.animateWithDuration(0.3) { () -> Void in
            self.alpha = 1.0
        }
    }

    /// Add shadow to the view.
    override func layoutSubviews() {
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 2).CGPath
    }

    // MARK: Configure controls

    /**
     Refresh all controls, show dialog, add observer to handle rotation

     - parameter superview: The view that will become the superview of LLDialog. Set to be `keyWindow` by default.
     */
    func show(inView superview: UIView? = UIApplication.sharedApplication().keyWindow){
        contentMode = .Redraw
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LLDialog.placeControls), name: UIDeviceOrientationDidChangeNotification, object: nil)
        addControls()
        placeControls()
        if let view = superview{
            view.addSubview(self)
        }
    }

    /**
     To configure labels

     - parameter lable:         The lable to configure
     - parameter text:          The text that will be displayed
     - parameter preferedFont:  Prefered font. If nil, will use the default font
     - parameter size:          Size of text
     - parameter preferedColor: Prefered color. If nil, will use the default color
     */
    private func configureLabel(inout lable: UILabel, text: String? = nil, font preferedFont: String? = nil, fontSize size: CGFloat, textColor preferedColor: UIColor? = nil){
        lable.text = text
        if let font = preferedFont{
            lable.font = UIFont(name: font, size: size)
        }
        if let color = preferedColor{
            lable.textColor = color
        }
        lable.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lable.numberOfLines = 0
    }

    /**
     To configure button

     - parameter button: The button to configure
     - parameter title:  The text that will be displayed
     */
    private func configureButton(inout button: UIButton, title: String? = nil){
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor(red:0.07, green:0.58, blue:0.96, alpha:1), forState: .Normal)
        button.titleLabel?.font = button.titleLabel?.font.fontWithSize(16)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
        button.sizeToFit()
        button.addTarget(self, action: #selector(LLDialog.disappear), forControlEvents: .TouchUpInside)
    }

    /// Configure controls and add them to the view
    private func addControls() {

        configureLabel(&titleLabel, text: title, font: "HelveticaNeue-Medium", fontSize: 18)
        configureLabel(&contentLabel, text: message, fontSize: 16, textColor: UIColor(red:0.49, green:0.49, blue:0.49, alpha:1))

        configureButton(&negativeButton, title: negativeText)
        configureButton(&positiveButton, title: positiveText)

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
    private func placeLabel(inout label: UILabel, width: CGFloat, y: CGFloat) {
        label.frame = CGRectMake(24, 0, width - 48, CGFloat.max)
        label.sizeToFit()
        label.frame.origin.y = y
    }

    /**
     Set the button frame

     - parameter button: The button to place
     - parameter x:      X position
     - parameter y:      Y position
     */
    private func placeButton(inout button: UIButton, x: CGFloat, y: CGFloat){
        let width = button.frame.width
        let height : CGFloat = 36
        button.frame = CGRectMake(x, y, width, height)
    }

    /// Place all controls to correct position.
    @objc private func placeControls() {

        let frame = UIScreen.mainScreen().bounds.size
        let width = frame.width * (7 / 9)

        placeLabel(&titleLabel, width: width, y: 24)
        let titleLabelHeight = titleLabel.frame.height

        placeLabel(&contentLabel, width: width, y: 24 + titleLabelHeight + 20)
        let contentLabelHeight = contentLabel.frame.height

        let viewWidth = width
        let viewHeight = 24 + titleLabelHeight + 20 + contentLabelHeight + 32 + 36 + 8
        let viewSize = CGSize(width: CGFloat(viewWidth), height: viewHeight)

        let screenBounds = UIScreen.mainScreen().bounds
        let screenWidth = screenBounds.width
        let screenHeight = screenBounds.height
        let viewPoint = CGPoint(x: (1 / 9) * screenWidth, y: screenHeight / 2 - CGFloat(viewHeight) / 2)
        self.frame = CGRect(origin: viewPoint, size: viewSize)
        self.backgroundColor = UIColor.whiteColor()

        let buttonY = viewHeight - 8 - 36
        let positiveButtonWidth = positiveButton.frame.width
        let positiveButtonX = viewWidth - 8 - positiveButtonWidth
        let negativeButtonWidth = negativeButton.frame.width
        placeButton(&positiveButton, x: positiveButtonX, y: buttonY)
        placeButton(&negativeButton, x: positiveButtonX - 8 - negativeButtonWidth, y: buttonY)
    }

    // MARK: Button actions

    /**
     Function about configuring positiveButton

     - parameters:
     - title: Title of positive button
     - target: The target object—that is, the object whose action method is called. Set to be nil by default, which means UIKit searches the responder chain for an object that responds to the specified action message and delivers the message to that object.
     - action: A selector identifying the action method to be called. Set to be nil by dafault, which means after taping the button, the LLDialog view disappears.
     */
    func setPositiveButton(title title: String, target: AnyObject? = nil,  action function: Selector? = nil){
        if !title.isBlank{
            positiveText = title
        }
        if let action = function{
            positiveButton.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
    }


    /**
     Function about configuring negativeButton

     - parameter title:    Title of negative button
     - parameter target:   The target object—that is, the object whose action method is called. Set to be nil by default, which means UIKit searches the responder chain for an object that responds to the specified action message and delivers the message to that object.
     - parameter function: A selector identifying the action method to be called. Set to be nil by dafault, which means after taping the button, the LLDialog view disappears.
     */
    func setNegativeButton(title title: String? = nil, target: AnyObject? = nil, action function: Selector? = nil){
        negativeText = title
        if let action = function{
            negativeButton.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
    }

    /// Disapper the view when tapped button, remove observer
    @objc private func disappear() {

        func delay(delay:Double, closure: ()->()) {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(delay * Double(NSEC_PER_SEC))
                ),
                dispatch_get_main_queue(), closure)
        }

        UIView.animateWithDuration(0.3) {
            self.alpha = 0.0
            self.cover.alpha = 0.0
        }

        delay(0.3) {
            self.cover.removeFromSuperview()
            self.removeFromSuperview()
        }
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
}

extension String {
    /// To check if the string contains characters other than white space and \n
    var isBlank: Bool {
        get {
            let trimmed = stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
            return trimmed.isEmpty
        }
    }
}
