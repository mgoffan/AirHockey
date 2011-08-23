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

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
