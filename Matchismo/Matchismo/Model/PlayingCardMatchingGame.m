//
//  PlayingCardMatchingGame.m
//  Matchismo
//
//  Created by ericyu on 2/13/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "PlayingCardMatchingGame.h"

@interface PlayingCardMatchingGame ()

@end


static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;


@implementation PlayingCardMatchingGame
-(void)chooseCardAtIndex:(NSUInteger)index
{
    int matchScore = 0;
    Card* card = [self cardAtIndex:index];
    if(card && !card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
            [self.cardsChosed removeObject:card];
        }
        else{
            [self.cardsChosed addObject:card];
            for(Card* otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    }
                    else{
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen=NO;
                    }
                    
                    break;
                }
            }

            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
    [self formatResult:self.cardsChosed matchScore:matchScore];
    return;
}

-(void) formatResult:(NSArray *)cards matchScore:(NSInteger)matchScore
{
        if(!cards || [cards count]==0)
            self.result = nil;

        if([cards count]==1){
            self.result =[NSString stringWithFormat:@"Result: %@",((Card*)cards[0]).contents];
        }
        else if([cards count]==2){
            
            if(matchScore){
                self.result =[NSString stringWithFormat:@"Result: Matched %@ %@ for %ld points.",
                              ((Card*)cards[0]).contents,
                              ((Card*)cards[1]).contents,
                              (long)matchScore];
                self.cardsChosed = nil;
            }
            else{
                self.result =[NSString stringWithFormat:@"Result: %@ %@ don't match!",
                              ((Card*)cards[0]).contents,
                              ((Card*)cards[1]).contents];
                [self.cardsChosed removeObjectAtIndex:0];
            }
        }
        else
            self.result=nil;
    
    return;
}

@end
