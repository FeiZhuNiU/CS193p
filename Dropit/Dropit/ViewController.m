//
//  ViewController.m
//  Dropit
//
//  Created by ericyu on 3/1/15.
//  Copyright (c) 2015 eric. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehavior.h"
#import "BezierPathView.h"

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet BezierPathView *gameView;
@property(strong,nonatomic)UIDynamicAnimator* animator;
@property(strong,nonatomic)DropitBehavior* dropitBehavior;
@property(strong,nonatomic)UIAttachmentBehavior* attachment;
@property(strong,nonatomic)UIView* droppingView;

@end

@implementation ViewController

static const CGSize DROP_SIZE = {40,40};

-(UIDynamicAnimator*)animator{
    if(!_animator){
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}

-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    [self removeCompleteRows];
}

-(void)removeCompleteRows{
    NSMutableArray* dropsToRemove = [[NSMutableArray alloc] init];
    
    for (CGFloat y = self.gameView.bounds.size.height - DROP_SIZE.height/2; y>0; y-=DROP_SIZE.height) {
        BOOL rowsIsComplete = YES;
        
        NSMutableArray* dropsFound = [[NSMutableArray alloc]init];
        
        for (CGFloat x = DROP_SIZE.width/2; x<=self.gameView.bounds.size.width-DROP_SIZE.width/2; x+=DROP_SIZE.width) {
            UIView* hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if([hitView superview] == self.gameView){
                [dropsFound addObject:hitView];
            }
            else{
                rowsIsComplete = NO;
                break;
            }
        }
        if (![dropsFound count]) {
            break;
        }
        
        if (!rowsIsComplete) {
            continue;
        }
        else{
            [dropsToRemove addObjectsFromArray:dropsFound];
        }
    }
    
    if([dropsToRemove count]){
        for(UIView* drop in dropsToRemove){
            [self.dropitBehavior removeItem:drop];
        }
        [self animateRemovingDrops:dropsToRemove];
    }
    
}

-(void)animateRemovingDrops:(NSArray*)dropsToRemove{
    [UIView animateWithDuration:1.0
                     animations:^{
                         for(UIView* drop in dropsToRemove){
                             int x= (arc4random()%(int)(self.gameView.bounds.size.width*5))-(int)self.gameView.bounds.size.width*2;
                             int y = self.gameView.bounds.size.height;
                             
                             drop.center=CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finished){
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     
                     }];
}






-(DropitBehavior*)dropitBehavior{
    if(!_dropitBehavior){
        _dropitBehavior = [[DropitBehavior alloc] init];
        [self.animator addBehavior:_dropitBehavior];
    }
    return _dropitBehavior;
}


- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    [self drop];
}
- (IBAction)pan:(UIPanGestureRecognizer *)sender
{
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    if(sender.state == UIGestureRecognizerStateBegan){
        [self attachDroppingViewToPoint:gesturePoint];
    }else if (sender.state == UIGestureRecognizerStateChanged){
        self.attachment.anchorPoint = gesturePoint;
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [self.animator removeBehavior:self.attachment];
        self.gameView.path = nil;
    }
}

-(void)attachDroppingViewToPoint:(CGPoint)anchorPoint
{
    if(self.droppingView)
    {
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.droppingView attachedToAnchor:anchorPoint];
        __weak ViewController* weakSelf = self;
        UIView* droppingView = self.droppingView;
        self.attachment.action=^{
            UIBezierPath* path = [[UIBezierPath alloc]init];
            [path moveToPoint:weakSelf.attachment.anchorPoint];
            [path addLineToPoint:droppingView.center];
            weakSelf.gameView.path = path;
        };
        
        self.droppingView = nil;
        [self.animator addBehavior:self.attachment];
    }
    
}

-(void)drop{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random()%(int)self.gameView.bounds.size.width)/DROP_SIZE.width;
    frame.origin.x = x*DROP_SIZE.width;
    
    UIView* dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
    self.droppingView = dropView;
    [self.dropitBehavior addItem:dropView];

}

-(UIColor*) randomColor{
    CGFloat red = arc4random()%256/255.0;
    CGFloat green = arc4random()%256/255.0;
    CGFloat blue = arc4random()%256/255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    return [UIColor redColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

