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
    
    var title = "Title"
    var content = "This is content."
    
    private var noButton = UIButton()
    private var yesButton = UIButton()
    private var titleLabel = UILabel()
    private var contentLabel = UILabel()
    private var cover = UIView()
    private var noText = "DISAGREE"
    private var yesText = "AGREE"

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
    
    /// Refresh all controls.
    func refreshUI() {
        
        addControls()
        placeControls()
    }
    
    /// Configure controls and add them to the view.
    private func addControls() {
        
        titleLabel.text = title
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        titleLabel.numberOfLines = 0
        
        contentLabel.text = content
        contentLabel.font = UIFont(name: contentLabel.font.fontName, size: 16)
        contentLabel.textColor = UIColor(red:0.49, green:0.49, blue:0.49, alpha:1)
        contentLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        contentLabel.numberOfLines = 0
        
        noButton.setTitle(noText, forState: .Normal)
        noButton.setTitleColor(UIColor(red:0.07, green:0.58, blue:0.96, alpha:1), forState: .Normal)
        noButton.titleLabel!.font = UIFont(name: noButton.titleLabel!.font.fontName, size: 16)
        noButton.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
        noButton.sizeToFit()
        noButton.addTarget(self, action: "disapper", forControlEvents: .TouchUpInside)
        
        yesButton.setTitle(yesText, forState: .Normal)
        yesButton.setTitleColor(UIColor(red:0.07, green:0.58, blue:0.96, alpha:1), forState: .Normal)
        yesButton.titleLabel!.font = UIFont(name: yesButton.titleLabel!.font.fontName, size: 16)
        yesButton.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
        yesButton.sizeToFit()
        yesButton.addTarget(self, action: "disapper", forControlEvents: .TouchUpInside)
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(noButton)
        addSubview(yesButton)
    }
    
    /// Place all controls to correct position.
    private func placeControls() {
        
        titleLabel.frame = CGRect(x: 24, y: 0, width: 202, height: CGFloat.max)
        titleLabel.sizeToFit()
        titleLabel.frame.origin.y += 24
        let titleLabelHeight = titleLabel.frame.height
        
        contentLabel.frame = CGRect(x: 24, y: 0, width: 202, height: CGFloat.max)
        contentLabel.sizeToFit()
        contentLabel.frame.origin.y += 24 + titleLabelHeight + 20
        let contentLabelHeight = contentLabel.frame.height
        
        let viewWidth = 250
        let viewHeight = 24 + titleLabelHeight + 20 + contentLabelHeight + 32 + 36 + 8
        let viewSize = CGSize(width: CGFloat(viewWidth), height: viewHeight)
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let viewPoint = CGPoint(x: screenWidth / 2 - 125, y: screenHeight / 2 - CGFloat(viewHeight) / 2)
        self.frame = CGRect(origin: viewPoint, size: viewSize)
        self.backgroundColor = UIColor.whiteColor()
        
        let yesButtonW = yesButton.frame.width
        let yesButtonH = CGFloat(36)
        let yesButtonX = CGFloat(CGFloat(viewWidth - 8) - yesButtonW)
        let yesButtonY = CGFloat(viewHeight - 8 - 36)
        yesButton.frame = CGRect(x: yesButtonX, y: yesButtonY, width: yesButtonW, height: yesButtonH)
        
        let noButtonW = noButton.frame.width
        let noButtonH = CGFloat(36)
        let noButtonX = CGFloat(CGFloat(yesButtonX - 8) - noButtonW)
        let noButtonY = CGFloat(viewHeight - 8 - 36)
        noButton.frame = CGRect(x: noButtonX, y: noButtonY, width: noButtonW, height: noButtonH)
    }
    
    // MARK: Button actions
    
    /// Function about configuring yesButton
    func setYesButton(target: AnyObject!, title: String, action: String) {
        
        yesText = title
        yesButton.addTarget(target, action: Selector(action), forControlEvents: .TouchUpInside)
    }
    
    /// Function about configuring noButton
    func setNoButton(target: AnyObject!, title: String, action: String) {
        
        noText = title
        noButton.addTarget(target, action: Selector(action), forControlEvents: .TouchUpInside)
    }
    
    /// Disapper the view when tapped button
    @objc private func disapper() {
        
        func delay(delay:Double, closure:()->()) {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(delay * Double(NSEC_PER_SEC))
                ),
                dispatch_get_main_queue(), closure)
        }
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.alpha = 0.0
            self.cover.alpha = 0.0
        }
        
        delay(0.3) { () -> () in
            self.cover.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
}
