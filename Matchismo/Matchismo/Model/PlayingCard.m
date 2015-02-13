//
//  PlayingCard.m
//  Matchismo
//
//  Created by ericyu on 2/4/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+(NSArray*) validSuits{
    return @[@"♣︎",@"♠︎",@"♥︎",@"♦︎"];
}

+(NSArray*) rankString{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger) maxRank{
    return [[self rankString] count] - 1;
}

-(NSString* ) contents{
    return [[PlayingCard rankString][self.rank] stringByAppendingString:self.suit];
}


@synthesize suit = _suit;
-(void) setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
-(NSString*) suit{
    return _suit ? _suit : @"?";
}

-(void)setRank:(NSUInteger)rank{
    if (rank<=[PlayingCard maxRank]) {
        _rank = rank;
    }
}

-(int) match:(NSArray *)otherCards{
    int score = 0;
    if([otherCards count] == 1){
        PlayingCard* othercard = [otherCards firstObject];
        if(self.rank == othercard.rank){
            score = 4;
        }
        else if([self.suit isEqualToString:othercard.suit]){
            score = 1;
        }
    }
    
    return score;
}

@end

