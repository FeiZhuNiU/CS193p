//
//  SetCard.m
//  Matchismo
//
//  Created by ericyu on 2/13/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


-(int) match:(NSArray *)otherCards{
    int score = 0;
    
    if([otherCards count] == 3){
        
        
        int score1 = [SetCard matchTwoCards:otherCards[0] anotherCard:otherCards[1]];
        int score2 = [SetCard matchTwoCards:otherCards[0] anotherCard:otherCards[2]];
        if(score1 == 0)
            score=score2;
        else if(score2 == 0)
            score = score1;
        else if(score1 == score2)
            score = score1*score2;
        else
            score = 2*(score1+score2);
    }
    
    
    return score;
}

+(int) matchTwoCards:(SetCard*)card1 anotherCard:(SetCard*) card2
{
    return 1;
}

@end
