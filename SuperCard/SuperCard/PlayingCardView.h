//
//  PlayingCardView.h
//  SuperCard
//
//  Created by ericyu on 2/17/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic,strong) NSString* suit;
@property (nonatomic) BOOL faceUp;    

@end
