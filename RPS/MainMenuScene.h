//
//  HelloWorldLayer.h
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

@interface MainMenuScene : CCScene {
    CCSprite *puck[2];
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
