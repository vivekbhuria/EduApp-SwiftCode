//
//  Rectangle.swift
//  Drawing App
//
//  Created by Vivek on 12/11/14.
//  Copyright (c) 2014 Vivek. All rights reserved.
//

import Foundation
import UIKit

class Rectangle: Shape
{
    var guideLinePathArray:NSMutableArray = [[NSValue(CGPoint:CGPoint(x: 300.0, y: 200.0)),NSValue(CGPoint:CGPoint(x: 300.0, y: 540.0))],[NSValue(CGPoint:CGPoint(x: 330.0, y: 550.0)),NSValue(CGPoint:CGPoint(x: 720.0, y: 550.0))],[NSValue(CGPoint:CGPoint(x: 715.0, y: 550.0)),NSValue(CGPoint:CGPoint(x: 715.0, y: 150))],[NSValue(CGPoint:CGPoint(x: 715.0, y: 155.0)),NSValue(CGPoint:CGPoint(x: 300.0, y: 155))]];
    
    var guideLineStartPointArray:NSMutableArray = [[NSValue(CGRect:CGRectMake(275, 140 , 52, 52))],[NSValue(CGRect:CGRectMake(300, 523 , 52, 52))],[NSValue(CGRect:CGRectMake(690, 510, 52, 52))],[NSValue(CGRect:CGRectMake(685, 130, 52, 52))]];
    
    var guideLineEndPointArray:NSMutableArray = [[NSValue(CGRect:CGRectMake(285, 530, 32, 32))],[NSValue(CGRect:CGRectMake(700, 530, 32, 32))],[NSValue(CGRect:CGRectMake(700, 145, 32, 32))],[NSValue(CGRect:CGRectMake(280, 135, 32, 32))]];
    
    var startAnchorAngle:NSMutableArray = [[NSNumber(double: 0.00)],[NSNumber(double: 270.00)],[NSNumber(double: 180.00)],[NSNumber(double: 90.00)]];
    
    var userTouchStartPointArr:NSMutableArray = [[NSValue(CGRect:CGRectMake(270, 150, 40, 30))],[NSValue(CGRect:CGRectMake(270, 535, 40, 30))],[NSValue(CGRect:CGRectMake(700, 530, 40, 30))],[NSValue(CGRect:CGRectMake(700, 140, 40, 30))]];
   
    var userTouchEndPointArr:NSMutableArray = [[NSValue(CGRect:CGRectMake(270, 545, 40, 25))],[NSValue(CGRect:CGRectMake(720, 545, 30, 25))],[NSValue(CGRect:CGRectMake(700, 140, 40, 25))],[NSValue(CGRect:CGRectMake(260, 140, 40, 30))]];
    
    override init(view:UIView)
    {
        super.init(view:view)
        self.drawTemplate = [NSValue(CGPoint:CGPoint(x: 300.0, y: 150.0)),NSValue(CGPoint:CGPoint(x: 300.0, y: 550.0)),NSValue(CGPoint:CGPoint(x: 720.0, y: 550.0)),NSValue(CGPoint:CGPoint(x: 720.0, y: 155.0)),NSValue(CGPoint:CGPoint(x: 300.0, y: 150.0))];
        
        self.drawnShapeName="Rectangle"
        self.numberOfStrokes=4;
        
        self.linesMade["Line1"] = "no";
        self.linesMade["Line2"] = "no";
        self.linesMade["Line3"] = "no";
        self.linesMade["Line4"] = "no";
        
        var objGuideLine:GuideLineData = GuideLineData();
        
        
        for var x=0; x<4; x++
        {
            var startPointArr:AnyObject = guideLineStartPointArray.objectAtIndex(x);
            var endPointArr:AnyObject = guideLineEndPointArray.objectAtIndex(x);
            var anchorAngle:AnyObject = startAnchorAngle.objectAtIndex(x);
            var userStartTouch:AnyObject = userTouchStartPointArr.objectAtIndex(x);
            var userEndTouch:AnyObject = userTouchEndPointArr.objectAtIndex(x);
            
            var objGuideLine:GuideLineData = GuideLineData();
            objGuideLine.guideLineDottedPathArray.addObject(guideLinePathArray.objectAtIndex(x));
            objGuideLine.guideLineDirectionStartPoint = startPointArr.objectAtIndex(0).CGRectValue()
            objGuideLine.guideLineDirectionEndPoint = endPointArr.objectAtIndex(0).CGRectValue()
            objGuideLine.guideLineAnchorAngle = anchorAngle.objectAtIndex(0).doubleValue;
            objGuideLine.userTouchStartPoint = userStartTouch.objectAtIndex(0).CGRectValue();
            objGuideLine.userTouchEndPoint = userEndTouch.objectAtIndex(0).CGRectValue();
            self.shapeMainGuideArray.addObject(objGuideLine);
        }
    }
    
    
    // MARK: Touch methods
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        let touchPoint: CGPoint! = touches.anyObject()?.locationInView(self.canvas)
        self.mainPath = UIBezierPath()
        self.mainPath.lineWidth=30;
        self.mainPath.moveToPoint(touchPoint);
        
        self.delayPath = UIBezierPath()
        self.delayPath.lineWidth=30;
        
        var objGuideLine = GuideLineData();
        objGuideLine = self.shapeMainGuideArray.objectAtIndex(self.drawnStrokes) as GuideLineData
        var notDone = "no"
        var done = "done"
        
        var touch : UITouch! = touches.anyObject() as UITouch!
        var center = touch.locationInView(self.canvas)
        
        if (linesMade["Line1"] == notDone)
        {
            if (CGRectContainsPoint(objGuideLine.userTouchStartPoint, center))
            {
                linesMade["Line1"] = "start"
                self.initiateDrawingLayer();
                self.shapeDelayPointArray.addObject(NSValue(CGPoint:touch.locationInView(self.canvas)))
            }
        }
        else if (linesMade["Line1"] == done && linesMade["Line2"] == notDone)
        {
            if (CGRectContainsPoint(objGuideLine.userTouchStartPoint, center))
            {
                linesMade["Line2"] = "start"
                self.initiateDrawingLayer();
                self.shapeDelayPointArray.addObject(NSValue(CGPoint:touch.locationInView(self.canvas)))
            }
        }
        else if (linesMade["Line2"] == done && linesMade["Line3"] == notDone)
        {
            if (CGRectContainsPoint(objGuideLine.userTouchStartPoint, center))
            {
                linesMade["Line3"] = "start";
                self.initiateDrawingLayer();
                self.shapeDelayPointArray.addObject(NSValue(CGPoint:touch.locationInView(self.canvas)))
            }
        }
        else if (linesMade["Line3"] == done && linesMade["Line4"] == notDone)
        {
            if (CGRectContainsPoint(objGuideLine.userTouchStartPoint, center))
            {
                linesMade["Line4"] = "start";
                self.initiateDrawingLayer();
                self.shapeDelayPointArray.addObject(NSValue(CGPoint:touch.locationInView(self.canvas)))
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        var objGuideLine = GuideLineData();
        objGuideLine = self.shapeMainGuideArray.objectAtIndex(self.drawnStrokes) as GuideLineData
        
        var start = "start"
        var done = "done"
        
        var touch : UITouch! = touches.anyObject() as UITouch!
        var center = touch.locationInView(self.canvas)
        
        var currentPos: CGPoint! = touches.anyObject()?.locationInView(self.canvas)
        mainPath.moveToPoint(currentPos);
        
        if (linesMade["Line1"] == start)
        {
            if (currentPos.x>285 && currentPos.x<305)
            {
                if (CGRectContainsPoint(objGuideLine.userTouchEndPoint, currentPos))
                {
                    linesMade["Line1"] = "done"
                    let count=self.shapeDelayPointArray.count;
                    
                    if (count>9)
                    {
                        for var x=count-10; x<count; x++
                        {
                            var pont = CGPoint();
                            let leftPtCount = self.shapeDelayArray.count
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(x);
                            pont = val.CGPointValue();
                            self.delayPath.addLineToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            [self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer)];
                        }
                    }
                    else
                    {
                        if (!lineStarted)
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(0);
                            pont = val.CGPointValue();
                            self.delayPath.moveToPoint(pont);
                            self.objCanvas.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            self.lineStarted=true;
                        }
                        for var x=0; x<count; x++
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(x);
                            pont = val.CGPointValue();
                            self.delayPath.addLineToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            [self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer)];
                        }
                    }
                    
                    self.lineStarted = false;
                    self.removePreviousGuideLines()
                    ++self.drawnStrokes
                    self.drawDirectionGuideLine()
                }
                else if (currentPos.y>145 && currentPos.y<545)
                {
                    self.objCanvas.self.customDrawingLayer.path = mainPath.CGPath;
                    [self.shapeArray.addObject(self.objCanvas.customDrawingLayer)];
                    self.shapeDelayPointArray.addObject(NSValue(CGPoint:currentPos))
                    if (self.shapeArray.count>9)
                    {
                        let count=self.shapeDelayPointArray.count;
                        var pont = CGPoint();
                        
                        if (!lineStarted)
                        {
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(0);
                            pont = val.CGPointValue();
                            self.delayPath.moveToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            lineStarted=true;
                        }
                        
                        var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(count-10);
                        pont = val.CGPointValue();
                        self.delayPath.addLineToPoint(pont);
                        self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                        [self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer)];
                    }
                }
                else
                {
                    linesMade["Line1"] = "no"
                    self.lineStarted = false;
                    var subLeftViews = self.shapeArray
                    var subViews = self.shapeDelayArray
                    
                    for subview in subLeftViews as [AnyObject]
                    {
                        subview.removeFromSuperlayer()
                    }
                    
                    for subview in subViews as [AnyObject]
                    {
                        subview.removeFromSuperlayer()
                    }
                    self.shapeArray.removeAllObjects();
                    self.shapeDelayArray.removeAllObjects();
                    self.shapeDelayPointArray.removeAllObjects()
                }
            }
        }
        else if (linesMade["Line2"] == start)
        {
            if (currentPos.y>515 && currentPos.y<565)
            {
                if (CGRectContainsPoint(objGuideLine.userTouchEndPoint, currentPos))
                {
                    linesMade["Line2"] = "done"
                    let count=self.shapeDelayPointArray.count;
                    
                    if (count>9)
                    {
                        for var x=count-10; x<count; x++
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(x);
                            pont = val.CGPointValue();
                            self.delayPath.addLineToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            [self.shapeDelayArray.addObject(objCanvas.self.customDrawingDelayLayer)];
                        }
                    }
                    else
                    {
                        if (!lineStarted)
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(0);
                            pont = val.CGPointValue();
                            self.delayPath.moveToPoint(pont);
                            self.objCanvas.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            self.lineStarted=true;
                        }
                        for var x=0; x<count; x++
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(x);
                            pont = val.CGPointValue();
                            self.delayPath.addLineToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = delayPath.CGPath;
                            let rightPtCount = self.shapeDelayArray.count
                            [self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer)];
                        }
                    }
                    
                    self.lineStarted=false;
                    self.removePreviousGuideLines()
                    ++self.drawnStrokes
                    self.drawDirectionGuideLine()
                }
                else if (currentPos.x>270 && currentPos.x<725)
                {
                    objCanvas.customDrawingLayer.path = mainPath.CGPath;
                    let rightPtCount = self.shapeArray.count
                    [self.shapeArray.addObject(objCanvas.customDrawingLayer)];
                    self.shapeDelayPointArray.addObject(NSValue(CGPoint:currentPos))
                    
                    if (self.shapeArray.count>9)
                    {
                        let count=self.shapeDelayPointArray.count;
                        var pont = CGPoint();
                        
                        if (!lineStarted)
                        {
                            
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(0);
                            pont = val.CGPointValue();
                            self.delayPath.moveToPoint(pont);
                            self.objCanvas.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            lineStarted=true;
                        }
                        
                        var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(count-10);
                        pont = val.CGPointValue();
                        self.delayPath.addLineToPoint(pont);
                        self.objCanvas.customDrawingDelayLayer.path = delayPath.CGPath;
                        self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer);
                    }
                }
                else
                {
                    linesMade["Line2"] = "no"
                    lineStarted = false;
                    var subRightViews = self.shapeArray
                    var subViews = self.shapeDelayArray
                    
                    for subview in subRightViews as [AnyObject]
                    {
                        subview.removeFromSuperlayer()
                    }
                    
                    for subview in subViews as [AnyObject]
                    {
                        subview.removeFromSuperlayer()
                    }
                }
            }
        }
        else if (linesMade["Line3"] == start)
        {
            if (currentPos.x>690 && currentPos.x<750)
            {
                if (CGRectContainsPoint(objGuideLine.userTouchEndPoint, currentPos))
                {
                    linesMade["Line3"] = "done"
                    let count = self.shapeDelayPointArray.count;
                    
                    if (count>9)
                    {
                        for var x=count-10; x<count; x++
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(x);
                            pont = val.CGPointValue();
                            self.delayPath.addLineToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            [self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer)];
                        }
                    }
                    else
                    {
                        if (!lineStarted)
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(0);
                            pont = val.CGPointValue();
                            self.delayPath.moveToPoint(pont);
                            self.objCanvas.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            self.lineStarted=true;
                        }
                        for var x=0; x<count; x++
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(x);
                            pont = val.CGPointValue();
                            [self.delayPath.addLineToPoint(pont)];
                            self.objCanvas.self.customDrawingDelayLayer.path = delayPath.CGPath;
                            [self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer)];
                        }
                    }
                    
                    self.lineStarted=false;
                    self.removePreviousGuideLines()
                    ++self.drawnStrokes
                    self.drawDirectionGuideLine()
                }
                else if (currentPos.y>145 && currentPos.y<550)
                {
                    self.objCanvas.customDrawingLayer.path = mainPath.CGPath;
                    [self.shapeArray.addObject(objCanvas.customDrawingLayer)];
                    [self.shapeDelayPointArray.addObject(NSValue(CGPoint:currentPos))]
                    
                    if (self.shapeArray.count>9)
                    {
                        let count=self.shapeDelayPointArray.count;
                        var pont = CGPoint();
                        
                        if (!lineStarted)
                        {
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(0);
                            pont = val.CGPointValue();
                            [self.delayPath.moveToPoint(pont)];
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            self.lineStarted=true;
                        }
                        
                        var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(count-10);
                        pont = val.CGPointValue();
                        [self.delayPath.addLineToPoint(pont)];
                        self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                        [self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer)];
                    }
                }
                else
                {
                    linesMade["Line3"] = "no"
                    var subMiddleViews = self.shapeArray
                    var subViews = self.shapeDelayArray
                    lineStarted = false;
                    for subview in subMiddleViews as [AnyObject]
                    {
                        subview.removeFromSuperlayer()
                    }
                    
                    for subview in subViews as [AnyObject]
                    {
                        subview.removeFromSuperlayer()
                    }
                }
            }
        }
        else if (linesMade["Line4"] == start)
        {
            if (currentPos.y>120 && currentPos.y<170)
            {
                if (CGRectContainsPoint(objGuideLine.userTouchEndPoint, currentPos))
                {
                    linesMade["Line4"] = "done"
                    let count=self.shapeDelayPointArray.count;
                    
                    if (count>9)
                    {
                        for var x=count-10; x<count; x++
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(x);
                            pont = val.CGPointValue();
                            self.delayPath.addLineToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            [self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer)];
                        }
                    }
                    else
                    {
                        if (!lineStarted)
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(0);
                            pont = val.CGPointValue();
                            self.delayPath.moveToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            self.lineStarted=true;
                        }
                        for var x=0; x<count; x++
                        {
                            var pont = CGPoint();
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(x);
                            pont = val.CGPointValue();
                            self.delayPath.addLineToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            let rightPtCount = self.shapeDelayArray.count
                            [self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer)];
                        }
                    }
                    
                    self.lineStarted=false;
                    self.removePreviousGuideLines()
                }
                else if (currentPos.x>270 && currentPos.x<725)
                {
                    self.objCanvas.self.customDrawingLayer.path = self.mainPath.CGPath;
                    let rightPtCount = self.shapeArray.count
                    [self.shapeArray.addObject(self.objCanvas.self.customDrawingLayer)];
                    self.shapeDelayPointArray.addObject(NSValue(CGPoint:currentPos))
                    
                    if (self.shapeArray.count>9)
                    {
                        let count=self.shapeDelayPointArray.count;
                        var pont = CGPoint();
                        
                        if (!lineStarted)
                        {
                            
                            var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(0);
                            pont = val.CGPointValue();
                            self.delayPath.moveToPoint(pont);
                            self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                            lineStarted=true;
                        }
                        
                        var val:AnyObject = self.shapeDelayPointArray.objectAtIndex(count-10);
                        pont = val.CGPointValue();
                        self.delayPath.addLineToPoint(pont);
                        self.objCanvas.self.customDrawingDelayLayer.path = self.delayPath.CGPath;
                        self.shapeDelayArray.addObject(self.objCanvas.self.customDrawingDelayLayer);
                    }
                }
                else
                {
                    linesMade["Line4"] = "no"
                    lineStarted = false;
                    var subRightViews = self.shapeArray
                    var subViews = self.shapeDelayArray
                    
                    for subview in subRightViews as [AnyObject]
                    {
                        subview.removeFromSuperlayer()
                    }
                    
                    for subview in subViews as [AnyObject]
                    {
                        subview.removeFromSuperlayer()
                    }
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        var objGuideLine = GuideLineData();
        objGuideLine=self.shapeMainGuideArray.objectAtIndex(self.drawnStrokes) as GuideLineData
        
        let currentPos: CGPoint! = touches.anyObject()?.locationInView(self.canvas)
        self.mainPath.moveToPoint(currentPos);
        
        var mytouch : UITouch! = touches.anyObject() as UITouch!
        var center = mytouch.locationInView(self.canvas)
        
        var start = "start"
        var notDone = "no"
        
        if (linesMade["Line1"]==start)
        {
            if (CGRectContainsPoint(objGuideLine.userTouchEndPoint, currentPos))
            {
                linesMade["Line1"] = "done"
                ++self.drawnStrokes
                drawDirectionGuideLine()
            }
            else
            {
                linesMade["Line1"] = "no"
                var subLeftViews = self.shapeArray
                var subViews = self.shapeDelayArray
                lineStarted = false;
                for subview in subLeftViews as [AnyObject]
                {
                    subview.removeFromSuperlayer()
                }
                
                for subview in subViews as [AnyObject]
                {
                    subview.removeFromSuperlayer()
                }
                self.shapeArray.removeAllObjects();
                self.shapeDelayArray.removeAllObjects();
                self.shapeDelayPointArray.removeAllObjects()
            }
        }
        else if (linesMade["Line1"]==notDone)
        {
            linesMade["Line1"] = "no"
            var subLeftViews = self.shapeArray
            var subViews = self.shapeDelayArray
            lineStarted = false;
            for subview in subLeftViews as [AnyObject]
            {
                subview.removeFromSuperlayer()
            }
            
            for subview in subViews as [AnyObject]
            {
                subview.removeFromSuperlayer()
            }
            self.shapeArray.removeAllObjects();
            self.shapeDelayArray.removeAllObjects();
            self.shapeDelayPointArray.removeAllObjects()
        }
        else if (linesMade["Line2"]==start)
        {
            if (CGRectContainsPoint(objGuideLine.userTouchEndPoint, currentPos))
            {
                linesMade["Line2"] = "done";
                ++self.drawnStrokes
                self.drawDirectionGuideLine()
            }
            else
            {
                linesMade["Line2"] = "no";
                var subRightViews = self.shapeArray
                var subViews = self.shapeDelayArray
                lineStarted = false;
                for subview in subRightViews as [AnyObject]
                {
                    subview.removeFromSuperlayer()
                }
                
                for subview in subViews as [AnyObject]
                {
                    subview.removeFromSuperlayer()
                }
                self.shapeArray.removeAllObjects();
                self.shapeDelayArray.removeAllObjects();
                self.shapeDelayPointArray.removeAllObjects()
            }
        }
        else if (linesMade["Line3"]==start)
        {
            if (CGRectContainsPoint(objGuideLine.userTouchEndPoint, currentPos))
            {
                linesMade["Line3"] = "done";
                self.removePreviousGuideLines()
            }
            else
            {
                linesMade["Line3"] = "no";
                var subMiddleViews = self.shapeArray
                var subViews = self.shapeDelayArray
                lineStarted = false;
                for subview in subMiddleViews as [AnyObject]
                {
                    subview.removeFromSuperlayer()
                }
                
                for subview in subViews as [AnyObject]
                {
                    subview.removeFromSuperlayer()
                }
                self.shapeArray.removeAllObjects();
                self.shapeDelayArray.removeAllObjects();
                self.shapeDelayPointArray.removeAllObjects()
            }
        }
        else if (linesMade["Line4"]==start)
        {
            if (CGRectContainsPoint(objGuideLine.userTouchEndPoint, currentPos))
            {
                linesMade["Line4"] = "done";
                self.removePreviousGuideLines()
            }
            else
            {
                linesMade["Line4"] = "no";
                var subMiddleViews = self.shapeArray
                var subViews = self.shapeDelayArray
                lineStarted = false;
                for subview in subMiddleViews as [AnyObject]
                {
                    subview.removeFromSuperlayer()
                }
                
                for subview in subViews as [AnyObject]
                {
                    subview.removeFromSuperlayer()
                }
                self.shapeArray.removeAllObjects();
                self.shapeDelayArray.removeAllObjects();
                self.shapeDelayPointArray.removeAllObjects()
            }
        }
    }
}
