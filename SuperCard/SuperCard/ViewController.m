//
//  ViewController.m
//  SuperCard
//
//  Created by ericyu on 2/17/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playingCardView.suit=@"♥︎";
    self.playingCardView.rank=13;
}



@end
