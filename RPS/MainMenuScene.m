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

- (void)closeEffect {
    CCAction *myAction = [CCSequence actions:[CCScaleTo actionWithDuration:0.33 scale:0.999f], [CCCallFunc actionWithTarget:self selector:@selector(startEffect)], nil];
    [menu runAction:myAction];
}

- (void)startEffect {
    CCAction *myAction = [CCSequence actions:[CCScaleTo actionWithDuration:0.33 scale:1.005f], [CCCallFunc actionWithTarget:self selector:@selector(closeEffect)], nil];
    [menu runAction:myAction];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        bg = [CCLayer node];
        CCSprite *sprite = [CCSprite spriteWithFile:@"bg.png"];
        sprite.position = ccp(240, 160);
        [bg addChild:sprite];
        
        CCParticleSnow *emitter = [[CCParticleSnow alloc] init];
        emitter.texture = [[CCTextureCache sharedTextureCache] addImage:@"snow.gif"];
        emitter.position = ccp(240, 320);
        emitter.speed = 15.0f;
        emitter.scale = 1.5f;
        [bg addChild:emitter];
        
        CCParticleRain *emitter2 = [[CCParticleRain alloc] init];
        emitter2.texture = [[CCTextureCache sharedTextureCache] addImage:@"raindrop.gif"];
        emitter2.position = ccp(240, 320);
        emitter2.speed = 15.0f;
        emitter2.scale = 1.5f;
        [bg addChild:emitter2];
        
		CCMenuItemFont *menuSinglePlayer    = [CCMenuItemFont itemFromString:@"Single Player" target:self selector:@selector(goSp)];
        CCMenuItemFont *menuMultiPlayer     = [CCMenuItemFont itemFromString:@"Multiplayer" target:self selector:@selector(goMp)];
        CCMenuItemFont *menuSettings        = [CCMenuItemFont itemFromString:@"Settings" target:self selector:@selector(goSettings)];
        CCMenuItemFont *menuAbout           = [CCMenuItemFont itemFromString:@"About" target:self selector:@selector(goAbout)];
        
#ifndef kRColor
#define kRColor 85
#endif
#ifndef kGColor
#define kGColor 0
#endif
#ifndef kBColor
#define kBColor 0
#endif
        
        ccColor3B menuColor = ccc3(kRColor, kGColor, kBColor);
        
        [menuSinglePlayer setColor:menuColor];
        [menuMultiPlayer setColor:menuColor];
        [menuSettings setColor:menuColor];
        [menuAbout setColor:menuColor];
        
        menu = [CCMenu menuWithItems:menuSinglePlayer, menuMultiPlayer, menuSettings, menuAbout, nil];
        [menu alignItemsVertically];
		
        [self addChild:bg];
		[self addChild: menu];
        
        [self startEffect];
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
