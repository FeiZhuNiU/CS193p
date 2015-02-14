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
        PlayingCard* another = otherCards[0];
        if(self.rank == another.rank){
            if([self.suit isEqualToString:another.suit])
                return 8;
            return 4;
        }
        if ([self.suit isEqualToString:another.suit]) {
            return 1;
        }
    }
//    else if([otherCards count] == 3){
//        int score1 = [PlayingCard matchTwoCards:otherCards[0] anotherCard:otherCards[1]];
//        int score2 = [PlayingCard matchTwoCards:otherCards[0] anotherCard:otherCards[2]];
//        if(score1 == 0)
//            score=score2;
//        else if(score2 == 0)
//            score = score1;
//        else if(score1 == score2)
//            score = score1*score2;
//        else
//            score = 2*(score1+score2);
//    }
    
    
    return score;
}

//+(int) matchTwoCards:(PlayingCard*)card1 anotherCard:(PlayingCard*) card2{
//    if(card1.rank == card2.rank){
//        if([card1.suit isEqualToString:card2.suit])
//            return 8;
//        return 4;
//    }
//    if ([card1.suit isEqualToString:card2.suit]) {
//        return 1;
//    }
//    return 0;
//}

@end

