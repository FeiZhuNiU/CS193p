//
//  PlayingCardView.m
//  SuperCard
//
//  Created by ericyu on 2/17/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

#pragma mark - properties

-(void) setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

-(void) setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

-(void) setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

-(CGFloat)cornerScaleFactor {return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;}
-(CGFloat)cornerRadius {return CORNER_RADIUS * [self cornerScaleFactor];}
-(CGFloat)cornerOffset {return [self cornerRadius] / 3.0;}
-(void)drawRect:(CGRect)rect
{
    UIBezierPath* roundedRect = [ UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    [self drawCorners];
    
}

-(NSString*) rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

-(void)drawCorners
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont* cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize*[self cornerScaleFactor]];
    
    NSAttributedString* cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString],self.suit] attributes:@{NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName:paragraphStyle}];
    
    
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
	    
    [cornerText drawInRect:textBounds];
}


#pragma mark - Initialization
-(void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

-(void)awakeFromNib
{
    [self setup];
}

@end
