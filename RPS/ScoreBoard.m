//
//  ScoreBoard.m
//  AirHockey
//
//  Created by Martin Goffan on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreBoard.h"

@implementation ScoreBoard

- (id)init
{
    self = [super init];
    if (self) {
        userScore = [NSNumber numberWithInt:0];
        COMScore  = [NSNumber numberWithInt:0];
        
        [self addChild:[CCSprite spriteWithFile:@"scoreboard.png"]];
        CCLabelTTF *Score1 = [CCLabelTTF labelWithString:[userScore stringValue] dimensions:CGSizeMake(20, 20) alignment:UITextAlignmentCenter fontName:@"Helvetica" fontSize:20.0f];
        CCLabelTTF *Score2 = [CCLabelTTF labelWithString:[COMScore stringValue] dimensions:CGSizeMake(20, 20) alignment:UITextAlignmentCenter fontName:@"Helvetica" fontSize:20.0f];
        Score1.anchorPoint = ccp(6, 27);
        Score2.anchorPoint = ccp(41, 27);
        Score1.position = ccp(0, 0);
        Score2.position = ccp(0, 0);
        
        [self addChild:Score1];
        [self addChild:Score2];
    }
    
    return self;
}

- (void)setUserScore:(NSNumber *)aScore {
    userScore = aScore;
}

- (void)setCOMScore:(NSNumber *)aScore {
    COMScore = aScore;
}

@end
