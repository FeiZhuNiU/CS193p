//
//  PlayingCard.h
//  Matchismo
//
//  Created by ericyu on 2/4/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString* suit;
@property (nonatomic) NSUInteger rank;

+(NSArray*) validSuits;
+(NSUInteger) maxRank;

@end
