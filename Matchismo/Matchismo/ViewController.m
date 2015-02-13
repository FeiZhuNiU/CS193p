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
//@property (weak, nonatomic) IBOutlet UILabel *flipslabel;
//@property (nonatomic) int flipCount;
//@property (nonatomic, strong) Deck* deck;
@property (nonatomic, strong) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation ViewController


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

-(CardMatchingGame*) game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

//-(Deck*) deck{
//    if (!_deck) {
//        _deck = [self createDeck];
//    }
//    return _deck;
//}

-(Deck*) createDeck{
    return [[PlayingCardDeck alloc] init ];
}

//-(void) setFlipCount:(int)flipCount
//{
//    _flipCount = flipCount;
//    [self.flipslabel setText:[NSString stringWithFormat:@"Flips: %d", self.flipCount]];
//}

- (IBAction)touchCardButton:(UIButton *)sender
{
    
//    if ([sender.currentTitle length]) {
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
//        [sender setTitle:@"" forState:UIControlStateNormal];
//    } else {
//        Card* randomCard = [self.deck drawRandomCard];
//        
//        if(randomCard){
//            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
//    //        [sender setTitle:@"A♣︎" forState:UIControlStateNormal];
//            [sender setTitle:randomCard.contents forState:UIControlStateNormal];
//            self.flipCount++;
//        }
//    }
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
}

-(void) updateUI{
    for(UIButton* cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    }
}

-(NSString*) titleForCard:(Card*) card{
    return card.isChosen ? card.contents : @"";
}

-(UIImage*) backgroundImageForCard:(Card*) card{
    return [UIImage imageNamed:card.isChosen?@"cardfront":@"cardback"];
}

@end







