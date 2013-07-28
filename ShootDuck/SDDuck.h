//
//  SDDuck.h
//  ShootDuck
//
//  Created by Teaualune Tseng on 13/7/28.
//  Copyright (c) 2013年 Teaualune Tseng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SpriteKit/SpriteKit.h>

typedef enum {
    yellowDuck,
    purpleDuck
} DuckColor;

@interface SDDuck : NSObject

@property (nonatomic, strong, readonly) SKSpriteNode *spriteNode;

@property (nonatomic, readonly) DuckColor color;

@property (nonatomic, readonly) NSInteger score;

- (void)update;

- (BOOL)containsPoint:(CGPoint)point;

@end
