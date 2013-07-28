//
//  SDShootDuckGame.m
//  ShootDuck
//
//  Created by Teaualune Tseng on 13/7/28.
//  Copyright (c) 2013年 Teaualune Tseng. All rights reserved.
//

#define GAMETIME 30

#import "SDShootDuckGame.h"

#import "SDDuck.h"

@implementation SDShootDuckGame

- (id)init
{
    self = [super init];
    if (self) {
        _ducks = [[NSMutableArray alloc] init];
        _score = 0;
        _remainingTime = GAMETIME;
    }
    return self;
}

- (void)updateTime:(NSTimer *)timer
{
    self.remainingTime -= timer.timeInterval;

    for (SDDuck *duck in self.ducks) {
        [duck update];
    }
}

- (void)reset
{
    self.score = 0;
    self.remainingTime = GAMETIME;
}

@end
