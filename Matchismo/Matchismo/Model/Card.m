//
//  Card.m
//  Matchismo
//
//  Created by ericyu on 2/3/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int) match:(NSArray *)cards
{
    int score = 0;

    for (Card* card in cards)
    {
        if([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    return score;
}

@end
