//
//  HypnosisView.swift
//  Hypnosister
//
//  Created by Troy Abel on 10/20/14.
//  Copyright (c) 2014 Troy Abel. All rights reserved.
//

import UIKit



class HypnosisView: UIView {
    
    //Add vars to control the radius and timer for the animation
    var radiusOffset: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var timer: NSTimer?
    
    //Override these two methods to set up and tear down the timer
    override func didMoveToSuperview() {
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0/30.0, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
        }
    }
    
    override func removeFromSuperview() {
        timer?.invalidate()
        timer = nil
        
        super.removeFromSuperview()
    }
    
    func timerFired(timer: NSTimer) {
//        println("pew")
        
        //Increment the radius offset
        radiusOffset += 1.0
        
        //Reset the radius offset at 20 to create a nice looping effect
        if radiusOffset > 20 {
            radiusOffset = 0
        }
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
    //Set all HypnosisViews start with a clear background color
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        let bounds = self.bounds
        
        // Figure out the center of the bounds rectangle
        let centerX = bounds.origin.x + bounds.size.width / 2.0
        let centerY = bounds.origin.y + bounds.size.height / 2.0
        let center = CGPoint(x: centerX, y: centerY)
        
        //The largest circle will circumscribe the view
        let maxRadius = CGFloat(hypot(CDouble(bounds.size.width), CDouble(bounds.size.height)) / 2)
        
        //Keep drawing bigger circles until the radius is larger than the maximum visible radius
        for var radius: CGFloat = 0.0; radius < maxRadius; radius += 20 {
        
        let path = UIBezierPath()
        
        //Add an arc to the path at the center, with a radius of 'radius',
        //from 0 to 2*PI radians (a circle)
        path.addArcWithCenter(center, radius: radius + radiusOffset, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        //Configure the stroke to 10 points and the color to purple
        path.lineWidth = 10
        
        //Change the alpha to mimic they are fading
        let alpha = ((radius + radiusOffset - 10) / maxRadius)
        UIColor.purpleColor().colorWithAlphaComponent(alpha).setStroke()
        
        //Draw the line
        path.stroke()
        }
    }
}
