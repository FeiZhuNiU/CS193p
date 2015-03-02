//
//  DropitBehavior.h
//  Dropit
//
//  Created by ericyu on 3/2/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior
-(void)addItem:(id <UIDynamicItem>)item;
-(void)removeItem:(id <UIDynamicItem>)item;
@end
