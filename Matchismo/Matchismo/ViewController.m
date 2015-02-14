//
//  ViewController.m
//  Matchismo
//
//  Created by ericyu on 2/3/15.
//  Copyright (c) 2015 eric. All rights reserved.
//
// abstract

#import "ViewController.h"
#import "CardMatchingGame.h"


@interface ViewController ()

@end

@implementation ViewController


-(CardMatchingGame*)game 
{
    if(!_game) _game = [self createGame];
    return _game;
}
-(CardMatchingGame*) createGame //abstract
{
    return nil;
}

-(Deck*) createDeck //abstract
{
    return nil;
}

- (IBAction)touchReDealButton:(UIButton *)sender
{
    self.game = nil;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
   
}

-(void) updateUI{
    for(UIButton* cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.gameResultLabel.text = self.game.result;
}

-(NSString*) titleForCard:(Card*) card{
    return card.isChosen ? card.contents : @"";
}

-(UIImage*) backgroundImageForCard:(Card*) card{
    return [UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"];
}

@end







