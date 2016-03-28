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
    
    var title: String? = "Title"
    var content: String? = "This is content."
    
    private var negativeButton = UIButton()
    private var positiveButton = UIButton()
    private var titleLabel = UILabel()
    private var contentLabel = UILabel()
    private var cover = UIView()
    private var negativeText: String?
    private var positiveText = "AGREE"

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
    
    /// Refresh all controls, show dialog, add observer to handle rotation
    func show(inView: UIView? = UIApplication.sharedApplication().keyWindow){
        contentMode = .Redraw
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(placeControls), name: UIDeviceOrientationDidChangeNotification, object: nil)
        addControls()
        placeControls()
        if let view = inView{
            view.addSubview(self)
        }
    }
    
    /// Configure controls and add them to the view
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
        
        negativeButton.setTitle(negativeText, forState: .Normal)
        negativeButton.setTitleColor(UIColor(red:0.07, green:0.58, blue:0.96, alpha:1), forState: .Normal)
        negativeButton.titleLabel!.font = UIFont(name: negativeButton.titleLabel!.font.fontName, size: 16)
        negativeButton.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
        negativeButton.sizeToFit()
        negativeButton.addTarget(self, action: #selector(LLDialog.disapper), forControlEvents: .TouchUpInside)
        
        positiveButton.setTitle(positiveText, forState: .Normal)
        positiveButton.setTitleColor(UIColor(red:0.07, green:0.58, blue:0.96, alpha:1), forState: .Normal)
        positiveButton.titleLabel!.font = UIFont(name: positiveButton.titleLabel!.font.fontName, size: 16)
        positiveButton.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
        positiveButton.sizeToFit()
        positiveButton.addTarget(self, action: #selector(LLDialog.disapper), forControlEvents: .TouchUpInside)
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(negativeButton)
        addSubview(positiveButton)
    }
    
    /// Place all controls to correct position.
    @objc private func placeControls() {
        
        let frame = UIScreen.mainScreen().bounds.size
        let width = frame.width * (7 / 9)
        
        titleLabel.frame = CGRect(x: 24, y: 0, width: width - 48, height: CGFloat.max)
        titleLabel.sizeToFit()
        titleLabel.frame.origin.y += 24
        let titleLabelHeight = titleLabel.frame.height
        
        contentLabel.frame = CGRect(x: 24, y: 0, width: width - 48, height: CGFloat.max)
        contentLabel.sizeToFit()
        contentLabel.frame.origin.y += 24 + titleLabelHeight + 20
        let contentLabelHeight = contentLabel.frame.height
        
        let viewWidth = width
        let viewHeight = 24 + titleLabelHeight + 20 + contentLabelHeight + 32 + 36 + 8
        let viewSize = CGSize(width: CGFloat(viewWidth), height: viewHeight)
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let viewPoint = CGPoint(x: (1 / 9) * screenWidth, y: screenHeight / 2 - CGFloat(viewHeight) / 2)
        self.frame = CGRect(origin: viewPoint, size: viewSize)
        self.backgroundColor = UIColor.whiteColor()
        
        let positiveButtonW = positiveButton.frame.width
        let positiveButtonH = CGFloat(36)
        let positiveButtonX = CGFloat(CGFloat(viewWidth - 8) - positiveButtonW)
        let positiveButtonY = CGFloat(viewHeight - 8 - 36)
        positiveButton.frame = CGRect(x: positiveButtonX, y: positiveButtonY, width: positiveButtonW, height: positiveButtonH)
        
        let negativeButtonW = negativeButton.frame.width
        let negativeButtonH = CGFloat(36)
        let negativeButtonX = CGFloat(CGFloat(positiveButtonX - 8) - negativeButtonW)
        let negativeButtonY = CGFloat(viewHeight - 8 - 36)
        negativeButton.frame = CGRect(x: negativeButtonX, y: negativeButtonY, width: negativeButtonW, height: negativeButtonH)
    }
    
    // MARK: Button actions
    
    /// Function about configuring positiveButton
    func setPositiveButton(target: AnyObject!, title: String, action arg: Selector?){
        positiveText = title
        if let action = arg{
            positiveButton.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
    }
    
    /// Function about configuring negativeButton
    func setNegativeButton(target: AnyObject!, title: String?, action arg: Selector?){
        negativeText = title
        if let action = arg{
            negativeButton.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
    }
    
    /// Disapper the view when tapped button, remove observer
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
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
}
