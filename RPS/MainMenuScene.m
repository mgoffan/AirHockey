//
//  HelloWorldLayer.m
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "MainMenuScene.h"
#import "SinglePlayerScene.h"
#import "MultiplayerScene.h"
#import "SettingsScene.h"
#import "AboutScene.h"

// HelloWorldLayer implementation
@implementation MainMenuScene

+(CCScene *) scene
{
//    MainMenuScene* f = [self node];
    CCScene *scene = (MainMenuScene *)[self node];
	return scene;
}

- (void)goSp {
    [[CCDirector sharedDirector] replaceScene:[SinglePlayerScene scene]];
}

- (void)goMp {
    [[CCDirector sharedDirector] replaceScene:[MultiplayerScene scene]];
}

- (void)goSettings {
    [[CCDirector sharedDirector] replaceScene:[SettingsScene scene]];
}

- (void)goAbout {
    [[CCDirector sharedDirector] replaceScene:[AboutScene scene]];
}

BOOL backx[2] = {NO, NO};
BOOL backy[2] = {NO, NO};

- (void)animatePuck {
    CGPoint nextPoint;
    
    if (puck[0].position.x == 490.0) {
        nextPoint.x = puck[1].position.x - 10.0;
        backx[0] = YES;
    }
    else {
        if (puck[0].position.x == -10.0) {
            nextPoint.x = puck[0].position.x + 10.0;
            backx[0] = NO;
        }
        else {
            if (backx[0]) {
                nextPoint.x = puck[0].position.x - 10.0;
            }
            else nextPoint.x = puck[0].position.x + 10.0;
        }
    }
    
    if (puck[0].position.y == -10.0) {
        nextPoint.y = puck[0].position.y + 10.0;
        backy[0] = YES;
    }
    else {
        if (puck[0].position.y == 330.0) {
            nextPoint.y = puck[0].position.y - 10.0;
            backy[0] = NO;
        }
        else {
            if (backy[0]) {
                nextPoint.y = puck[0].position.y + 10.0;
            }
            else nextPoint.y = puck[0].position.y - 10.0;
        }
    }
    
    CCAction *myAction = [CCSequence actions:[CCMoveTo actionWithDuration:.33 position:nextPoint], [CCCallFunc actionWithTarget:self selector:@selector(animatePuck)],nil];
    [puck[0] runAction:myAction];
    
}

- (void)animatePuck2 {
    CGPoint nextPoint;
    
    if (puck[1].position.x == 490.0) {
        nextPoint.x = puck[1].position.x - 10.0;
        backx[1] = YES;
    }
    else {
        if (puck[1].position.x == -10.0) {
            nextPoint.x = puck[1].position.x + 10.0;
            backx[1] = NO;
        }
        else {
            if (backx[1]) {
                nextPoint.x = puck[1].position.x - 10.0;
            }
            else nextPoint.x = puck[1].position.x + 10.0;
        }
    }
    
    if (puck[1].position.y == -10.0) {
        nextPoint.y = puck[1].position.y + 10.0;
        backy[1] = YES;
    }
    else {
        if (puck[1].position.y == 330.0) {
            nextPoint.y = puck[1].position.y - 10.0;
            backy[1] = NO;
        }
        else {
            if (backy[1]) {
                nextPoint.y = puck[1].position.y + 10.0;
            }
            else nextPoint.y = puck[1].position.y - 10.0;
        }
    }
    
    CCAction *myAction = [CCSequence actions:[CCMoveTo actionWithDuration:.33 position:nextPoint], [CCCallFunc actionWithTarget:self selector:@selector(animatePuck2)],nil];
    [puck[1] runAction:myAction];
    
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        CCLayer *background = [CCLayer node];
        CCSprite *sprite = [CCSprite spriteWithFile:@"bg.png"];
        sprite.position = ccp(240, 160);
        [background addChild:sprite];
        
        puck[0] = [CCSprite spriteWithFile:@"puck.png"];
        puck[0].position = ccp(0, 0);
        puck[1] = [CCSprite spriteWithFile:@"puck.png"];
        puck[1].position = ccp(320, 480);
        
        [background addChild:puck[0]];
        [background addChild:puck[1]];
        
		CCMenuItemFont *menuSinglePlayer    = [CCMenuItemFont itemFromString:@"Single Player" target:self selector:@selector(goSp)];
        CCMenuItemFont *menuMultiPlayer     = [CCMenuItemFont itemFromString:@"Multiplayer" target:self selector:@selector(goMp)];
        CCMenuItemFont *menuSettings        = [CCMenuItemFont itemFromString:@"Settings" target:self selector:@selector(goSettings)];
        CCMenuItemFont *menuAbout           = [CCMenuItemFont itemFromString:@"About" target:self selector:@selector(goAbout)];
        
        [menuSinglePlayer setColor:ccc3(0, 0, 0)];
        [menuMultiPlayer setColor:ccc3(0, 0, 0)];
        [menuSettings setColor:ccc3(0, 0, 0)];
        [menuAbout setColor:ccc3(0, 0, 0)];
        
        CCMenu *menu = [CCMenu menuWithItems:menuSinglePlayer, menuMultiPlayer, menuSettings, menuAbout, nil];
        [menu alignItemsVertically];
		
        [self addChild:background];
		[self addChild: menu];
        
        [self animatePuck];
        [self animatePuck2];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
