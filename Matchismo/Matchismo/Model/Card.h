//
//  Card.h
//  Matchismo
//
//  Created by ericyu on 2/3/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString* contents;

@property (nonatomic,getter=isChosen) BOOL chosen;
@property (nonatomic,getter=isMatched) BOOL matched;

-(int) match : (NSArray*) cards;

@end
