//
//  HelloWorldLayer.h
//  RPS
//
//  Created by Martin Goffan on 8/18/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#define kNumberOfPucks 15

@interface MainMenuScene : CCScene {
    CCLayer *bg;
    
    CCMenu *menu;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
