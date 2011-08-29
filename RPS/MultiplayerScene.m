//
//  MultiplayerScene.m
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultiplayerScene.h"

@implementation MultiplayerScene

+(CCScene *) scene
{
    //    MainMenuScene* f = [self node];
    CCScene *scene = (MultiplayerScene *)[self node];
	return scene;
}

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"touch began");
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    [puck[(location.x > 240 ? 1 : 0)] setPosition:location];
    return YES;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches began");
    CGPoint location = [[[touches allObjects] objectAtIndex:0] locationInView:[[[touches allObjects] objectAtIndex:0] view]];
    CGPoint location2 = [[[touches allObjects] objectAtIndex:1] locationInView:[[[touches allObjects] objectAtIndex:1] view]];
    if (location.x > 240) {
        location2 = [[CCDirector sharedDirector] convertToGL:location2];
        [puck[1] setPosition:location2];
    }
    else {
        location = [[CCDirector sharedDirector] convertToGL:location];
        [puck[0] setPosition:location];
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch move");
	CGPoint location = [[[touches allObjects] objectAtIndex:0] locationInView:[[[touches allObjects] objectAtIndex:0] view]];
    CGPoint location2 = [[[touches allObjects] objectAtIndex:1] locationInView:[[[touches allObjects] objectAtIndex:1] view]];
	if (location.x > 240) {
        location = [[CCDirector sharedDirector] convertToGL:location];
        [puck[1] setPosition:location2];
    }
    else {
        location = [[CCDirector sharedDirector] convertToGL:location];
        [puck[0] setPosition:location];
    }
    if (location2.x > 240) {
        location = [[CCDirector sharedDirector] convertToGL:location];
        [puck[1] setPosition:location2];
    }
    else {
        location2 = [[CCDirector sharedDirector] convertToGL:location];
        [puck[0] setPosition:location];
    }
}

BOOL backx2 = NO;
BOOL backy2 = NO;

- (void)somebodyWon:(BOOL)aYes {
    CCLabelTTF *label;
    if (aYes) label = [CCLabelTTF labelWithString:@"YOU WON!!!" fontName:@"Marker Felt" fontSize:48.0];
    else label = [CCLabelTTF labelWithString:@"YOU LOST!!!" fontName:@"Marker Felt" fontSize:48.0];
    [label setColor:ccc3(0, 0, 0)];
    label.position = ccp(240, 160);
    label.scale = 0.0f;
    
    [gameLayer addChild:label z:1];
    
    CCAction *myAction = [CCFadeIn actionWithDuration:3.0];
    CCAction *myAction2 = [CCScaleTo actionWithDuration:1.5 scale:1.0f];
    [label runAction:myAction];
    [label runAction:myAction2];
}

- (void)animateController {
    CGPoint nextPoint = CGPointMake(puck[1].position.x, ball.position.y);
    CCAction *myAction = [CCSequence actions:[CCMoveTo actionWithDuration:0.22 position:nextPoint], [CCCallFunc actionWithTarget:self selector:@selector(animateController)], nil];
    [puck[1] runAction:myAction];
}

- (void)animatePuck {
#ifndef kAccelXAxis
#define kAccelXAxis 5.0
#endif
    
#ifndef kAccelYAxis
#define kAccelYAxis 2.5
#endif
    
    CGPoint nextPoint;
    if (ball.position.x == 480.0) {
        nextPoint.x = ball.position.x - kAccelXAxis;
        backx2 = YES;
        [self somebodyWon:YES];
    }
    else {
        if (ball.position.x == 0.0) {
            nextPoint.x = ball.position.x + kAccelXAxis;
            backx2 = NO;
            [self somebodyWon:NO];
        }
        else {
            if (backx2) {
                nextPoint.x = ball.position.x - kAccelXAxis;
            }
            else nextPoint.x = ball.position.x + kAccelXAxis;
        }
    }
    
    if (ball.position.y == 0.0) {
        nextPoint.y = ball.position.y + kAccelYAxis;
        backy2 = YES;
    }
    else {
        if (ball.position.y == 320.0) {
            nextPoint.y = ball.position.y - kAccelYAxis;
            backy2 = NO;
        }
        else {
            if (backy2) {
                nextPoint.y = ball.position.y + kAccelYAxis;
            }
            else nextPoint.y = ball.position.y - kAccelYAxis;
        }
    }
    
    CCAction *myAction = [CCSequence actions:[CCMoveTo actionWithDuration:0.01 position:nextPoint], [CCCallFunc actionWithTarget:self selector:@selector(animatePuck)], [CCCallFunc actionWithTarget:self selector:@selector(collisionDetector)],nil];
    [ball runAction:myAction];
}

- (void)collisionDetector {
    BOOL b0 = CGRectIntersectsRect(puck[1].boundingBox, ball.boundingBox);
    BOOL b1 = CGRectIntersectsRect(puck[0].boundingBox, ball.boundingBox);
    
    if (b0 || b1) {
        NSLog(@"collision");
        
        backy2 = (puck[0].position.y < ball.position.y) ? YES : NO;
        backx2 = (b1) ? NO : YES;
    }
}

- (void)setUpBackground {
    CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
    bg.position = ccp(240, 160);
    bgLayer.isTouchEnabled = NO;
    [bgLayer addChild:bg];
}

- (void)setUpGameLayer {
    puck[0] = [CCSprite spriteWithFile:@"puck.png"];
    puck[1] = [CCSprite spriteWithFile:@"puck.png"];
    puck[0].position = ccp(20, 160);
    puck[1].position = ccp(460, 160);
    gameLayer.isTouchEnabled = YES;
    [gameLayer addChild:puck[0] z:0];
    [gameLayer addChild:puck[1] z:0];
    
    ball = [CCSprite spriteWithFile:@"g.png"];
    
    [gameLayer addChild:ball z:0];
    ball.position = ccp(240, 160);
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"init");
        
        [self registerWithTouchDispatcher];
        
        bgLayer = [CCLayer node];
        gameLayer = [CCLayer node];
        
        [self setUpBackground];
        [self setUpGameLayer];
        
        [self animatePuck];
//        [self animateController];
        
        [self addChild:bgLayer z:0];
        [self addChild:gameLayer z:1];
    }
    
    return self;
}

@end
