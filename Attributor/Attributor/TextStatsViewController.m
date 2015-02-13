//
//  TextStatsViewController.m
//  Attributor
//
//  Created by ericyu on 2/13/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

-(void)setText:(NSAttributedString *)text
{
    _text = text;
    if(self.view.window)
        [self updateUI];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}



-(void) updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters",[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d outlined characters",[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

-(NSAttributedString*) charactersWithAttribute:(NSString*)attributeName
{
    NSMutableAttributedString* ret = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    
    while (index < [self.text length]) {
        NSRange range;
        id value = [self.text attribute:attributeName atIndex:index effectiveRange:&range];
        if(value){
            [ret appendAttributedString:[self.text attributedSubstringFromRange:range]];
            index =range.location + range.length;
        } else {
            ++index;
        }
    }
    return ret;
}


@end
