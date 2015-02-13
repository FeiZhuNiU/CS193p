//
//  Deck.h
//  Matchismo
//
//  Created by ericyu on 2/4/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

-(void)addCard:(Card*)card atTop:(BOOL)atTop;
-(void)addCard:(Card*)card;

-(Card*)drawRandomCard;

@end
