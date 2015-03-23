//
//  ViewController.m
//  Imaginarium
//
//  Created by ericyu on 3/21/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[ImageViewController class]])
    {
        ImageViewController* ivc =(ImageViewController*)segue.destinationViewController;
        ivc.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.sinaimg.cn/dy/slidenews/4_img/2015_12/%@.jpg",segue.identifier]];
        ivc.title = segue.identifier;
    }
}

@end
