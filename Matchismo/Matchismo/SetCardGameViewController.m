//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by ericyu on 2/13/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "SetCardMatchingGame.h"

@implementation SetCardGameViewController


-(Deck*) createDeck
{
    return [[PlayingCardDeck alloc] init];
}
-(CardMatchingGame*)createGame
{
    return [[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
}
@end
