//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by ericyu on 2/5/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

-(instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck;


-(void) chooseCardAtIndex:(NSUInteger)index;

-(Card*) cardAtIndex:(NSUInteger)index;

@property(nonatomic,readonly) NSInteger score;


@end
