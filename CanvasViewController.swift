//
//  CanvasViewController.swift
//  Drawing App
//
//  Created by Vivek on 12/11/14.
//  Copyright (c) 2014 Vivek. All rights reserved.
//

import Foundation
import UIKit

class CanvasViewController: UIViewController
{    
    //Drawing variabless
    var mainLayerArray:NSMutableArray;
    
    //Main view on which drawing is done
    var drawingView:UIView;
    //Objects of parent class
    var objSequencer:Sequencer;
    
    @IBOutlet var nextButtonOutlet: UIButton!
    @IBOutlet var previousButtonOutlet: UIButton!
    
    //Bool to check if line has started
    
    //Common methods of view controller
    required init(coder aDecoder: NSCoder)
    {
        mainLayerArray = NSMutableArray();
        drawingView = UIView();
        objSequencer = Sequencer(canvas:drawingView);
        super.init(coder: aDecoder);
    }
   
    // MARK: View Did Load
    override func viewDidLoad()
    {
         //Instanstiate Sequencer
        initiatedrawingView();
        objSequencer = Sequencer(canvas:drawingView);
        mainLayerArray.removeAllObjects();
        drawNextShape();
        previousButtonOutlet.hidden=true;
        
    }
    
    func initiatedrawingView()
    {
        self.view.viewWithTag(3003)?.removeFromSuperview();
        drawingView = UIView();
        drawingView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.height, self.view.frame.width-100)
        drawingView.backgroundColor=UIColor.whiteColor()
        drawingView.tag=3003;
        self.view.addSubview(drawingView)
    }
    
    // MARK: Func to draw next shape
    
    func drawNextShape()
    {
        var currentShape = objSequencer.nextShape;
        var shapeLayerMain:CAShapeLayer=CAShapeLayer();
        var shapeLayerBorder:CAShapeLayer=CAShapeLayer();
        
        let mainFrame = drawCurrentShape(currentShape.drawTemplate, deviceType: "", alphabet: "")
        shapeLayerMain=mainFrame.main;
        shapeLayerBorder=mainFrame.Border;
        
        mainLayerArray=[shapeLayerMain,shapeLayerBorder]
        
        // Adding all the layers to the Canvas
        drawingView.layer.addSublayer(shapeLayerBorder);
        drawingView.layer.addSublayer(shapeLayerMain);
        currentShape.drawDirectionGuideLine();
    
    }
    
    // MARK: Reallocating all arrays
    
    @IBAction func previousShapeButtonClicked(sender: AnyObject)
    {
        initiatedrawingView()
        objSequencer = Sequencer(canvas:drawingView);
        nextButtonOutlet.hidden=false;
        previousButtonOutlet.hidden=true;
        var currentShape = objSequencer.getPreviousShape()
        currentShape.drawnStrokes=0;
        
        //Remove all last drawn layers
        var secondLy = currentShape.shapeDelayArray
        for subview in secondLy as [AnyObject]
        {
            subview.removeFromSuperlayer()
        }
        
        var subMiddleViews = currentShape.shapeArray
        for subview in subMiddleViews as [AnyObject]
        {
            subview.removeFromSuperlayer()
        }

        mainLayerArray.removeAllObjects();
        
        var shapeLayerMain:CAShapeLayer=CAShapeLayer();
        var shapeLayerBorder:CAShapeLayer=CAShapeLayer();
        let mainFrame = drawCurrentShape(currentShape.drawTemplate, deviceType: "", alphabet: "")
        shapeLayerMain=mainFrame.main;
        shapeLayerBorder=mainFrame.Border;
        
        mainLayerArray=[shapeLayerMain,shapeLayerBorder]
        
        // Adding all the layers to the Canvas
        drawingView.layer.addSublayer(shapeLayerBorder)
        drawingView.layer.addSublayer(shapeLayerMain)
        currentShape.drawDirectionGuideLine()

    }
    
    // MARK: Next shape button click
    @IBAction func nextShapeButtonClicked(sender: AnyObject)
    {
        initiatedrawingView()
        objSequencer = Sequencer(canvas:drawingView);
        var currentShape = objSequencer.getNextShape();
        currentShape.drawnStrokes=0;
            
        nextButtonOutlet.hidden=true;
        previousButtonOutlet.hidden=false;
        
        //Remove all last drawn layers
        var secondLayer = currentShape.shapeDelayArray
        for subview in secondLayer as [AnyObject]
        {
            subview.removeFromSuperlayer()
        }
        
        mainLayerArray.removeAllObjects();
        
        var shapeLayerMain:CAShapeLayer=CAShapeLayer();
        var shapeLayerBorder:CAShapeLayer=CAShapeLayer();
        let mainFrame = drawCurrentShape(currentShape.drawTemplate, deviceType: "", alphabet: "")
        shapeLayerMain=mainFrame.main;
        shapeLayerBorder=mainFrame.Border;
        
        mainLayerArray=[shapeLayerMain,shapeLayerBorder]
        
        // Adding all the layers to the Canvas
        drawingView.layer.addSublayer(shapeLayerBorder)
        drawingView.layer.addSublayer(shapeLayerMain)
        currentShape.drawDirectionGuideLine()
        
    }
    
    // MARK: Drawing the current shape on Canvas
    func drawCurrentShape(pointArray:NSMutableArray, deviceType:NSString, alphabet:NSString) -> (main: CAShapeLayer, Border: CAShapeLayer)
    {
        var currentDrawPath:UIBezierPath = UIBezierPath()
        var currentLayerForDrawing:CAShapeLayer=CAShapeLayer()
        var currentLayerForDrawingBorder:CAShapeLayer=CAShapeLayer()
        
        let count=pointArray.count;
        
        for var x=0; x<count; x++
        {
            var pont = CGPoint();
            var val:AnyObject = pointArray.objectAtIndex(x);
            pont = val.CGPointValue();
            
            if (x==0)
            {
                currentDrawPath.moveToPoint(pont)
            }
            else
            {
                currentDrawPath.addLineToPoint(pont)
            }
        }
        
        currentLayerForDrawing.path = currentDrawPath.CGPath
        currentLayerForDrawing.strokeColor = UIColor.whiteColor().CGColor
        currentLayerForDrawing.lineWidth = 50.0
        currentLayerForDrawing.fillColor = UIColor.clearColor().CGColor
        currentLayerForDrawing.lineJoin = kCALineJoinRound;
        currentLayerForDrawing.lineCap = kCALineCapRound;
        
        currentLayerForDrawingBorder.path = currentDrawPath.CGPath
        currentLayerForDrawingBorder.strokeColor = UIColor.blackColor().CGColor
        currentLayerForDrawingBorder.lineWidth = 55.0;
        currentLayerForDrawingBorder.fillColor = UIColor.clearColor().CGColor
        currentLayerForDrawingBorder.lineJoin = kCALineJoinRound;
        currentLayerForDrawingBorder.lineCap = kCALineCapRound;
        
        return (currentLayerForDrawing,currentLayerForDrawingBorder)
    }
    
    // MARK: Over riding Touch functions
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        var currentShape = objSequencer.nextShape;
        currentShape.touchesBegan(touches, withEvent: event);
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        var currentShape = objSequencer.nextShape;
        currentShape.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        var currentShape = objSequencer.nextShape;
        currentShape.touchesEnded(touches, withEvent: event);
    }
}