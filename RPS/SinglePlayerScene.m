//
//  SinglePlayerScene.m
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SinglePlayerScene.h"

@implementation SinglePlayerScene

+(CCScene *) scene
{
    //    MainMenuScene* f = [self node];
    CCScene *scene = (SinglePlayerScene *)[self node];
	return scene;
}

- (void)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"began");
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"moved");
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"began");
    UITouch* myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView: [myTouch view]];
    location = [[CCDirector sharedDirector]convertToGL:location];
//    CGRect MoveableSpriteRect = CGRectMake(_MoveableSprite.position.x – (_MoveableSprite.contentSize.width/2),
//                                           _MoveableSprite.position.y – (_MoveableSprite.contentSize.height/2),
//                                           _MoveableSprite.contentSize.width,
//                                           _MoveableSprite.contentSize.height);
//    if (CGRectContainsPoint(MoveableSpriteRect, location)) {
//        _MoveableSprite1touch=TRUE;
//    }
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"moved");
    UITouch *myTouch = [touches anyObject];
    CGPoint point = [myTouch locationInView:[myTouch view]];
    point = [[CCDirector sharedDirector] convertToGL:point];
    [puck[0] setPosition:point];
//    if(_MoveableSprite1touch==TRUE){
//        [_MoveableSprite setPosition:point];
//    }
}

//- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
//    NSLog(@"began");
//    return YES;
//}
//
//- (BOOL)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
//    NSLog(@"moved");
//    return YES;
//}
//
//- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"began");
//    UITouch* myTouch = [touches anyObject];
//    CGPoint location = [myTouch locationInView: [myTouch view]];
//    location = [[CCDirector sharedDirector]convertToGL:location];
//    //    CGRect MoveableSpriteRect = CGRectMake(_MoveableSprite.position.x – (_MoveableSprite.contentSize.width/2),
//    //                                           _MoveableSprite.position.y – (_MoveableSprite.contentSize.height/2),
//    //                                           _MoveableSprite.contentSize.width,
//    //                                           _MoveableSprite.contentSize.height);
//    //    if (CGRectContainsPoint(MoveableSpriteRect, location)) {
//    //        _MoveableSprite1touch=TRUE;
//    //    }
//    return YES;
//}
//
//-(BOOL) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"moved");
//    UITouch *myTouch = [touches anyObject];
//    CGPoint point = [myTouch locationInView:[myTouch view]];
//    point = [[CCDirector sharedDirector] convertToGL:point];
//    [puck[0] setPosition:point];
//    //    if(_MoveableSprite1touch==TRUE){
//    //        [_MoveableSprite setPosition:point];
//    //    }
//    return YES;
//}

//-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    _MoveableSprite1touch=FALSE;
//}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"init");
        
        bgLayer = [CCLayer node];
        gameLayer = [CCLayer node];
        
        CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
        bg.position = ccp(240, 160);
        bgLayer.isTouchEnabled = NO;
        [bgLayer addChild:bg];
        
        puck[0] = [CCSprite spriteWithFile:@"puck.png"];
        puck[1] = [CCSprite spriteWithFile:@"puck.png"];
        puck[0].position = ccp(20, 160);
        puck[1].position = ccp(460, 160);
        gameLayer.isTouchEnabled = YES;
        [gameLayer addChild:puck[0]];
        [gameLayer addChild:puck[1]];
        
        [self addChild:bgLayer z:0];
        [self addChild:gameLayer z:1];
    }
    
    return self;
}

@end
