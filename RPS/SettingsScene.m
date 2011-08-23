//
//  SettingsScene.m
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsScene.h"

@implementation SettingsScene

+(CCScene *) scene
{
    //    MainMenuScene* f = [self node];
    CCScene *scene = (SettingsScene *)[self node];
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
