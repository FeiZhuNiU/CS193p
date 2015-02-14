//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by ericyu on 2/13/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardMatchingGame.h"

@implementation PlayingCardGameViewController

-(Deck*) createDeck
{
    return [[PlayingCardDeck alloc] init];
}
-(CardMatchingGame*)createGame
{
    return [[PlayingCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
}


@end
