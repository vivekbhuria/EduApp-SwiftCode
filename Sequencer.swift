//
//  Sequencer.swift
//  Drawing App
//
//  Created by Vivek on 12/11/14.
//  Copyright (c) 2014 Vivek. All rights reserved.
//

import Foundation
import UIKit

// This class will fetch shapes to drawn from database, based on a TBD alogrithm which factors in the user performance. This will act both as the shape sequencer and provider

class Sequencer
{
    //Array to store the shapes
    var shapeArray:NSMutableArray;
    
    //Current index to show
    var currentShapeIndex:Int;
    
    //string to get name
    var nextShape:Shape;
    
    init(canvas:UIView)
    {
        shapeArray = [ AlphabetA(view: canvas) , Rectangle(view: canvas)]
        self.currentShapeIndex = 0;
        self.nextShape = shapeArray.objectAtIndex(currentShapeIndex) as Shape;
    }
    
    //Function to get the next shape from Array
    func getNextShape() -> (Shape)
    {
        if(currentShapeIndex <= shapeArray.count)
        {
            ++currentShapeIndex;
            nextShape = shapeArray.objectAtIndex(currentShapeIndex) as Shape;
        }
        
        return nextShape;
    }
    
    //Function to get teh previous shape from Array
    func getPreviousShape() -> (Shape)
    {
        --currentShapeIndex;
        if(currentShapeIndex >= 0)
        {
            nextShape = shapeArray.objectAtIndex(currentShapeIndex) as Shape;
        }
        return nextShape;
    }
}