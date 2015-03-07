//
//  BezierPathView.m
//  Dropit
//
//  Created by ericyu on 3/7/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

-(void)setPath:(UIBezierPath *)path
{
    _path = path;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [self.path stroke];
}

@end
