//
//  SinglePlayerScene.m
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SinglePlayerScene.h"
#import "ScoreBoard.h"

@implementation SinglePlayerScene

+(CCScene *) scene
{
    //    MainMenuScene* f = [self node];
    CCScene *scene = (SinglePlayerScene *)[self node];
	return scene;
}

- (void)registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    [puck[0] setPosition:location];
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"touch move");
	CGPoint location = [touch locationInView:[touch view]];
	location = [[CCDirector sharedDirector] convertToGL:location];
    
    if (location.x >= 240) location.x = 240;
    
    [puck[0] setPosition:location];
}

BOOL backx = NO;
BOOL backy = NO;

- (void)removeLabel {
    [gameLayer removeChildByTag:3 cleanup:NO];
    [self animatePuck];
}

- (void)resetGame {
    CGPoint nextPoint = CGPointMake(240, 160);
    [ball stopActionByTag:10];
    [ball runAction:[CCMoveTo actionWithDuration:2.5 position:nextPoint]];
}

- (void)somebodyWon:(BOOL)aYes {
    CCLabelTTF *label;
    if (aYes) label = [CCLabelTTF labelWithString:@"YOU WON!!!" fontName:@"Marker Felt" fontSize:48.0];
    else label = [CCLabelTTF labelWithString:@"YOU LOST!!!" fontName:@"Marker Felt" fontSize:48.0];
    [label setColor:ccc3(0, 0, 0)];
    label.position = ccp(240, 160);
    label.scale = 0.0f;
    
    [label setTag:3];
    [gameLayer addChild:label z:1];
    
    CCAction *myAction = [CCSequence actions:[CCSpawn actions:[CCCallFunc actionWithTarget:self selector:@selector(resetGame)] , [CCFadeIn actionWithDuration:3.0], [CCScaleTo actionWithDuration:1.5 scale:1.0f], nil], [CCCallFunc actionWithTarget:self selector:@selector(removeLabel)], nil];
    [label runAction:myAction];
}

- (void)animateController {
    CGPoint nextPoint = CGPointMake(puck[1].position.x, ball.position.y);
    CCAction *myAction = [CCSequence actions:[CCMoveTo actionWithDuration:0.22 position:nextPoint], [CCCallFunc actionWithTarget:self selector:@selector(animateController)], nil];
    [puck[1] runAction:myAction];
}

- (void)animatePuck {
#ifndef kAccelXAxis
#define kAccelXAxis 4.0
#endif
    
#ifndef kAccelYAxis
#define kAccelYAxis 5.0
#endif
    
    CGPoint nextPoint;
        if (ball.position.x == 480.0) {
            nextPoint.x = ball.position.x - kAccelXAxis;
            backx = YES;
            [self somebodyWon:YES];
        }
        else {
            if (ball.position.x == 0.0) {
                nextPoint.x = ball.position.x + kAccelXAxis;
                backx = NO;
                [self somebodyWon:NO];
            }
            else {
                if (backx) {
                    nextPoint.x = ball.position.x - kAccelXAxis;
                }
                else nextPoint.x = ball.position.x + kAccelXAxis;
            }
        }
        
        if (ball.position.y == 0.0) {
            nextPoint.y = ball.position.y + kAccelYAxis;
           backy = YES;
        }
        else {
            if (ball.position.y == 320.0) {
                nextPoint.y = ball.position.y - kAccelYAxis;
                backy = NO;
            }
            else {
                if (backy) {
                    nextPoint.y = ball.position.y + kAccelYAxis;
                }
                else nextPoint.y = ball.position.y - kAccelYAxis;
            }
        }
    
    CCAction *myAction = [CCSequence actions:[CCMoveTo actionWithDuration:0.01 position:nextPoint], [CCCallFunc actionWithTarget:self selector:@selector(animatePuck)], [CCCallFunc actionWithTarget:self selector:@selector(collisionDetector)],nil];
    [myAction setTag:10];
    [ball runAction:myAction];
}

- (void)collisionDetector {
    BOOL b0 = CGRectIntersectsRect(puck[1].boundingBox, ball.boundingBox);
    BOOL b1 = CGRectIntersectsRect(puck[0].boundingBox, ball.boundingBox);
    
    if (b0 || b1) {
        NSLog(@"collision");
        
        backy = (puck[0].position.y < ball.position.y) ? YES : NO;
        backx = (b1) ? NO : YES;
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
    [puck[0] setTag:0];
    [puck[1] setTag:1];
    gameLayer.isTouchEnabled = YES;
    [gameLayer addChild:puck[0] z:0];
    [gameLayer addChild:puck[1] z:0];
    
    ball = [CCSprite spriteWithFile:@"g.png"];
    [ball setTag:2];
    [gameLayer addChild:ball z:0];
    ball.position = ccp(240, 160);
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"init");
        
        ScoreBoard* myScoreBoard = [[ScoreBoard alloc] init];
        [myScoreBoard setCOMScore:[NSNumber numberWithInt:0]];
        [myScoreBoard setUserScore:[NSNumber numberWithInt:0]];
        
        myScoreBoard.position = ccp(200, 200);
        
        [gameLayer addChild:myScoreBoard z:99];
        
        [self registerWithTouchDispatcher];
        
        bgLayer = [CCLayer node];
        gameLayer = [CCLayer node];
        
        [self setUpBackground];
        [self setUpGameLayer];
        
        [self animatePuck];
        [self animateController];
        
        [self addChild:bgLayer z:0];
        [self addChild:gameLayer z:1];
    }
    
    return self;
}

@end
