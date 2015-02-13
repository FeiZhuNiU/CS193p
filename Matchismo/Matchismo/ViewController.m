//
//  ViewController.m
//  Matchismo
//
//  Created by ericyu on 2/3/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface ViewController ()
@property (nonatomic, strong) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameModeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gameModeSwitchButton;
@property (weak, nonatomic) IBOutlet UILabel *gameResultLabel;
@end

@implementation ViewController

-(CardMatchingGame*) game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}


-(Deck*) createDeck{
    return [[PlayingCardDeck alloc] init ];
}

- (IBAction)gameModeSwitchButton:(UISwitch *)sender {
    self.game.gameMode = self.game.gameMode == 2 ? 3 : 2;
    [self updateUI];
}

- (IBAction)touchReDealButton:(UIButton *)sender
{
    self.game = nil;
    self.gameModeSwitchButton.enabled = YES;
    [self.gameModeSwitchButton setOn:self.game.gameMode==2];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.gameModeSwitchButton.enabled = NO;
    [self updateUI];
   
}

-(void) updateUI{
    for(UIButton* cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    }
    self.gameModeLabel.text = [NSString stringWithFormat:@"GameMode: %d", self.game.gameMode];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.gameResultLabel.text = self.game.result;
}

-(NSString*) titleForCard:(Card*) card{
    return card.isChosen ? card.contents : @"";
}

-(UIImage*) backgroundImageForCard:(Card*) card{
    return [UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"];
}

@end







