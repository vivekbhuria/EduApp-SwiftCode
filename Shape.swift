//
//  Shape.swift
//  Drawing App
//
//  Created by Vivek on 11/11/14.
//  Copyright (c) 2014 Vivek. All rights reserved.
//

import Foundation
import UIKit

// This class is the base class for all shapes in the application. It contains vars and methods common to all shapes.

class Shape
{
    var drawTemplate:NSMutableArray;
    var drawnShapeName:NSString;
    var numberOfStrokes:Int;
    var drawnStrokes:Int;
    var shapeMainGuideArray:NSMutableArray;
    var canvas:UIView;
    var shapeArray:NSMutableArray;
    var shapeDelayArray:NSMutableArray;
    var shapeDelayPointArray:NSMutableArray;
    var linesMade:Dictionary<String, String>;
    var objCanvas:CanvasLayer;
    var mainPath:UIBezierPath;
    var delayPath:UIBezierPath;
    var lineStarted:Bool;
    var dottedPathArray:NSMutableArray;
    
    init(view:UIView)
    {
        //Initiate the parameters
        self.canvas = view;
        drawTemplate = [];
        drawnShapeName="";
        numberOfStrokes=0;
        drawnStrokes=0;
        shapeMainGuideArray = [];
        shapeArray = [];
        shapeDelayArray = [];
        shapeDelayPointArray = [];
        linesMade = Dictionary<String, String>();
        objCanvas = CanvasLayer();
        mainPath = UIBezierPath();
        delayPath = UIBezierPath();
        lineStarted = Bool();
        dottedPathArray = NSMutableArray();
    }
    
    func RemovePreviousGuideLines()
    {
        
    }
    
    func drawItself()
    {
        
    }
    func getName()
    {
        
    }
    func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        
    }
    func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        
    }
    func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        
    }
    
    // MARK: Initializing Layers for drawing
    func initiateDrawingLayer()
    {        
        objCanvas.customDrawingLayer = CAShapeLayer ();
        objCanvas.customDrawingLayer.strokeColor = UIColor.clearColor().CGColor;
        objCanvas.customDrawingLayer.lineWidth = 30.0;
        objCanvas.customDrawingLayer.name = "x-2002";
        objCanvas.customDrawingLayer.lineJoin = kCALineJoinBevel;
        objCanvas.customDrawingLayer.fillColor = UIColor.clearColor().CGColor;
        objCanvas.customDrawingLayer.lineCap = kCALineCapRound;
        self.canvas.layer.addSublayer(objCanvas.customDrawingLayer);
        
        objCanvas.customDrawingDelayLayer = CAShapeLayer ();
        objCanvas.customDrawingDelayLayer.strokeColor = UIColor.redColor().CGColor;
        objCanvas.customDrawingDelayLayer.lineWidth = 30.0;
        objCanvas.customDrawingLayer.name = "x-2003";
        objCanvas.customDrawingDelayLayer.lineJoin = kCALineJoinBevel;
        objCanvas.customDrawingDelayLayer.fillColor = UIColor.clearColor().CGColor;
        objCanvas.customDrawingDelayLayer.lineCap = kCALineCapRound;
        self.canvas.layer.addSublayer(objCanvas.customDrawingDelayLayer);
    }
    
    // MARK: Drawing Guide Lines for user
    func drawDirectionGuideLine()
    {
        var objGuideLine = GuideLineData();
        self.shapeArray.removeAllObjects();
        self.shapeDelayArray.removeAllObjects();
        self.shapeDelayPointArray.removeAllObjects()
        
        objGuideLine=self.shapeMainGuideArray.objectAtIndex(self.drawnStrokes) as GuideLineData
        
        var drawGuideLine = drawingGuideLine(objGuideLine.guideLineDottedPathArray, EndPoint:objGuideLine.guideLineDirectionEndPoint, AnchorPoint :objGuideLine.guideLineDirectionStartPoint, AnchorAngle:objGuideLine.guideLineAnchorAngle);
        
        // Adding all the layers to the Canvas
        self.canvas.layer.addSublayer(drawGuideLine.baseLine);
        self.canvas.layer.addSublayer(drawGuideLine.starIcon);
        self.canvas.layer.addSublayer(drawGuideLine.AnchorIcon);
    }
    
    // MARK: Drawing guides lines for current shape on Canvas
    
    func drawingGuideLine(pointArray:NSMutableArray, EndPoint:CGRect , AnchorPoint:CGRect , AnchorAngle:Double) -> (baseLine: CAShapeLayer, starIcon: CALayer, AnchorIcon: CALayer)
    {
        var path:UIBezierPath = UIBezierPath()
        //draw a line
        var parsingArr:AnyObject = pointArray.objectAtIndex(0);
        let count=parsingArr.count;
        
        for var x=0; x<count; x++
        {
            var pont = CGPoint();
            var val:AnyObject = parsingArr.objectAtIndex(x);
            
            pont = val.CGPointValue();
            
            if (x==0)
            {
                path.moveToPoint(pont)
            }
            else
            {
                path.addLineToPoint(pont)
            }
        }
        
        var dashPattern = [CGFloat(2.0),CGFloat(5.0),CGFloat(4.0),CGFloat(2.0)]; //make your pattern here
        path.setLineDash(dashPattern, count: 4, phase: 3.0);
        
        //For adding dots and stars
        var shapeLayerDot:CAShapeLayer=CAShapeLayer();
        shapeLayerDot.strokeStart = 0.0;
        shapeLayerDot.strokeColor = UIColor.grayColor().CGColor;
        shapeLayerDot.lineWidth = 3.0;
        shapeLayerDot.lineJoin = kCALineJoinMiter;
        shapeLayerDot.lineDashPattern = [12,10];
        shapeLayerDot.lineDashPhase = 3.0;
        shapeLayerDot.path = path.CGPath;
        
        var starimage = UIImage(named: "star_iPad.png")  as UIImage!
        var anchorimage = UIImage(named: "anchor_iPad.png")  as UIImage!
        
        var pointImage:CALayer = CALayer();
        pointImage.frame = EndPoint;
        pointImage.contents = starimage.CGImage;
        
        var anchorImage:CALayer = CALayer();
        anchorImage.frame = AnchorPoint;
        anchorImage.contents = anchorimage.CGImage;
        
        var rotatedTransform:CATransform3D = anchorImage.transform;
        rotatedTransform = CATransform3DRotate(rotatedTransform, CGFloat(AnchorAngle * M_PI) / 180.0, 0.0, 0.0, 1.0);
        anchorImage.transform = rotatedTransform;
        self.dottedPathArray = [shapeLayerDot,pointImage,anchorImage];
        
        return (shapeLayerDot,pointImage,anchorImage)
    }
    
    // MARK: Removing guide Lines
    
    func removePreviousGuideLines()
    {
        var subViews = dottedPathArray
        for subview in subViews as [AnyObject]
        {
            subview.removeFromSuperlayer()
        }
    }
    
}


class UserPerformanceDB
{
    func addResults(childName:NSString, shapeName:NSString, score:Int32)
    {
        
    }
}
