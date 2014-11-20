//
//  CanvasLayer.swift
//  Drawing App
//
//  Created by Vivek on 13/11/14.
//  Copyright (c) 2014 Vivek. All rights reserved.
//

import Foundation
import UIKit

//utility class
class CanvasLayer
{
    var customDrawingLayer:CAShapeLayer;
    var customDrawingDelayLayer:CAShapeLayer;
    
    init()
    {
        customDrawingLayer = CAShapeLayer();
        customDrawingDelayLayer = CAShapeLayer();
    }
}