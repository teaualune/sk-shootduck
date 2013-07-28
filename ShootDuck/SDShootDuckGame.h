//
//  SDShootDuckGame.h
//  ShootDuck
//
//  Created by Teaualune Tseng on 13/7/28.
//  Copyright (c) 2013年 Teaualune Tseng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDShootDuckGame : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *ducks;

@property NSInteger score;

@property (nonatomic) CGFloat remainingTime;

@property (nonatomic, strong) NSTimer *gameTimer;

- (void)updateTime:(NSTimer *)timer;

- (void)reset;

@end
