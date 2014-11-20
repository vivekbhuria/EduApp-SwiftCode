//
//  GuideLineData.swift
//  Drawing App
//
//  Created by Vivek on 13/11/14.
//  Copyright (c) 2014 Vivek. All rights reserved.
//

import Foundation
import UIKit

//utility class
class GuideLineData
{
    //Parameters for Third Guide Path
    var guideLineDottedPathArray:NSMutableArray;
    var guideLineDirectionStartPoint:CGRect;
    var guideLineDirectionEndPoint:CGRect;
    var guideLineAnchorAngle:Double;
    
    //Touch Began Points
    var userTouchStartPoint:CGRect;
    var userTouchEndPoint:CGRect;
    
    init()
    {
        guideLineDottedPathArray = [];
        guideLineDirectionStartPoint = CGRectMake(0, 0, 0, 0);
        guideLineDirectionEndPoint = CGRectMake(0, 0, 0, 0);
        guideLineAnchorAngle=0.00;
        
        userTouchStartPoint=CGRectMake(0,0,0,0);
        userTouchEndPoint=CGRectMake(0,0,0,0);
    }
}