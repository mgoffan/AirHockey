//
//  MultiplayerScene.h
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface MultiplayerScene : CCScene <CCTargetedTouchDelegate, CCStandardTouchDelegate> {
    CCLayer *bgLayer;
    CCLayer *gameLayer;
    
    CCSprite *puck[2];
    
    CCSprite *ball;
}

+(CCScene *) scene;
@end
