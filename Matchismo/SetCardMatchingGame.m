//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by ericyu on 2/13/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "SetCardMatchingGame.h"

@implementation SetCardMatchingGame

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    int matchScore = 0;
    Card* card = [self cardAtIndex:index];
    if(card && !card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
            [self.cardsChosed removeObject:card];
            [self formatResult:self.cardsChosed matchScore:matchScore];
        }
        else{

            [self.cardsChosed addObject:card];
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            if([self.cardsChosed count] == 3){
                matchScore = [card match:self.cardsChosed];
                [self formatResult:self.cardsChosed matchScore:matchScore];
                if(matchScore){
                    self.score += matchScore * MATCH_BONUS;

                    for(int i =0; i < 3 ; i++){
                        Card* matchedCard = self.cardsChosed[0];
                        matchedCard.matched = YES;

                        [self.cardsChosed removeObject:matchedCard];
                    }
                }
                else{
                    self.score -= MISMATCH_PENALTY;
                    for(int i =0; i < 2 ; i++){
                        Card* unmatchedCard = self.cardsChosed[0];
                        unmatchedCard.chosen = NO;

                        [self.cardsChosed removeObject:unmatchedCard];
                    }
                }
                
                
            }
            else{
                [self formatResult:self.cardsChosed matchScore:matchScore];
            }
            
            
        }
    }
    
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
        self.result =[NSString stringWithFormat:@"Result: %@ %@",((Card*)cards[0]).contents,((Card*)cards[1]).contents];
    }
    else if([cards count]==3){
        if(matchScore){
            self.result =[NSString stringWithFormat:@"Result: Matched %@ %@ %@ for %ld points.",
                          ((Card*)cards[0]).contents,
                          ((Card*)cards[1]).contents,
                          ((Card*)cards[2]).contents,
                          (long)matchScore];
        }
        else{
            self.result =[NSString stringWithFormat:@"Result: %@ %@ %@ don't match!",
                          ((Card*)cards[0]).contents,
                          ((Card*)cards[1]).contents,
                          ((Card*)cards[2]).contents];
        }
    }

    else{
        self.result=nil;
    }
    return;
}


@end
