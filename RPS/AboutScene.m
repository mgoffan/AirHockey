//
//  AboutScene.m
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutScene.h"

@implementation AboutScene

+(CCScene *) scene
{
    //    MainMenuScene* f = [self node];
    CCScene *scene = (AboutScene *)[self node];
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
