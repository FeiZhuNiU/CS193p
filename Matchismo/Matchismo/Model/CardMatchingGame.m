//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by ericyu on 2/5/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property(nonatomic,readwrite)NSInteger score;
@property(nonatomic,strong) NSMutableArray* cards;// of card
@property(nonatomic,strong) NSMutableArray* cardsToMatch;
@end


@implementation CardMatchingGame
-(NSString*)result
{
    if(!_result)
        _result = @"Result: ";
    return _result;
}
-(NSInteger)gameMode
{
    if(_gameMode!=2 && _gameMode!=3)
        _gameMode = 2;
    return _gameMode;
}
-(NSMutableArray*) cardsToMatch{
    if(!_cardsToMatch)
        _cardsToMatch = [[NSMutableArray alloc] init];
    return _cardsToMatch;
}
-(NSMutableArray*) cards
{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    if(self){
        for (int i=0; i < count; i++){
            Card* card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }
            else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

-(Card*) cardAtIndex:(NSUInteger)index{
    return index<[self.cards count] ? self.cards[index] : nil;
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;


-(void) chooseCardAtIndex:(NSUInteger)index{
    
    NSMutableArray* cardsChosed = [[NSMutableArray alloc]init];
    int matchScore=0;
    if(self.gameMode == 2)
    {
        Card* card = [self cardAtIndex:index];
        if(card && !card.isMatched){
            if(card.isChosen){
                card.chosen = NO;
            }
            else{
                [cardsChosed addObject:card];
                for(Card* otherCard in self.cards){
                    if(otherCard.isChosen && !otherCard.isMatched){
                        [cardsChosed addObject:otherCard];
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
        
    }
    else if (self.gameMode == 3)
    {
        
        Card* card = [self cardAtIndex:index];
        if(card && !card.isMatched){
            if(card.isChosen){
                card.chosen = NO;
                [self.cardsToMatch removeObject:card];
            }
            else{
                
                [self.cardsToMatch addObject:card];
                cardsChosed = [NSMutableArray arrayWithArray:self.cardsToMatch];
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
                if([self.cardsToMatch count] == 3){
                    matchScore = [card match:self.cardsToMatch];
                    if(matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        
                        for(int i =0; i < 3 ; i++){
                            Card* matchedCard = self.cardsToMatch[0];
                            matchedCard.matched = YES;
                            
                            [self.cardsToMatch removeObject:matchedCard];
                        }
                    }
                    else{
                        self.score -= MISMATCH_PENALTY;
                        for(int i =0; i < 2 ; i++){
                            Card* unmatchedCard = self.cardsToMatch[0];
                            unmatchedCard.chosen = NO;
                            
                            [self.cardsToMatch removeObject:unmatchedCard];
                        }
                    }
                    
                    
                }
                
                
            }
            
        }
        
    }
    [self formatResult:cardsChosed matchScore:matchScore];
    return;
}

-(void) formatResult:(NSArray*)cards matchScore:(NSInteger)matchScore{
    if(!cards || [cards count]==0)
        self.result = nil;
    if(self.gameMode==2){
        if([cards count]==1){
            self.result =[NSString stringWithFormat:@"Result: %@",((Card*)cards[0]).contents];
        }
        else if([cards count]==2){
            if(matchScore){
                self.result =[NSString stringWithFormat:@"Result: Matched %@ %@ for %d points.",
                              ((Card*)cards[0]).contents,
                              ((Card*)cards[1]).contents,
                              matchScore];
            }
            else{
                self.result =[NSString stringWithFormat:@"Result: %@ %@ don't match!",
                              ((Card*)cards[0]).contents,
                              ((Card*)cards[1]).contents];
            }
        }
        else
            self.result=nil;
    }
    else if (self.gameMode==3){
        if([cards count]==1){
            self.result =[NSString stringWithFormat:@"Result: %@",((Card*)cards[0]).contents];
        }
        else if([cards count]==2){
            self.result =[NSString stringWithFormat:@"Result: %@ %@",((Card*)cards[0]).contents,((Card*)cards[1]).contents];
        }
        else if([cards count]==3){
            if(matchScore){
                self.result =[NSString stringWithFormat:@"Result: Matched %@ %@ %@ for %d points.",
                              ((Card*)cards[0]).contents,
                              ((Card*)cards[1]).contents,
                              ((Card*)cards[2]).contents,
                              matchScore];
            }
            else{
                self.result =[NSString stringWithFormat:@"Result: %@ %@ %@ don't match!",
                              ((Card*)cards[0]).contents,
                              ((Card*)cards[1]).contents,
                              ((Card*)cards[2]).contents];
            }
        }
        else
            self.result=nil;
    }
    return;
        
}

@end
