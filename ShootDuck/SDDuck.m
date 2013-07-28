//
//  SDDuck.m
//  ShootDuck
//
//  Created by Teaualune Tseng on 13/7/28.
//  Copyright (c) 2013年 Teaualune Tseng. All rights reserved.
//

#import "SDDuck.h"

@interface SDDuck ()

@property (nonatomic) CGFloat speed;
@property (nonatomic) CGFloat size;
@property (nonatomic, getter = isFlipX) BOOL flipX;

@end

@implementation SDDuck

- (id)init
{
    self = [super init];
    if (self) {
        _size = 40 + arc4random() % 20;
        _speed = 1 + arc4random() % 3;
        _flipX = arc4random() % 2;

        int r = arc4random() % 10;
        if (r == 0) {
            _spriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"duck2"];
            _color = purpleDuck;
            _speed += 3;
            _score = 10;
        } else {
            _spriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"duck1"];
            _color = yellowDuck;
            _score = 3;
        }

        _spriteNode.size = CGSizeMake(_size, _size);
        if (_flipX) {
            _spriteNode.position = CGPointMake(320 + _size, 30 + arc4random() % 420);
            _spriteNode.xScale = -1.0;
        } else {
            _spriteNode.position = CGPointMake(-_size, 30 + arc4random() % 420);
        }
    }
    return self;
}

- (void)update
{
    if (self.isFlipX) {
        self.spriteNode.position = CGPointMake(self.spriteNode.position.x - self.speed, self.spriteNode.position.y);
    } else {
        self.spriteNode.position = CGPointMake(self.spriteNode.position.x + self.speed, self.spriteNode.position.y);
    }
}

- (BOOL)containsPoint:(CGPoint)point
{
    CGRect frame = self.spriteNode.frame;
    CGRect detectFrame = CGRectMake(frame.origin.x - 5, frame.origin.y - 5, frame.size.width + 10, frame.size.height + 10);
    return CGRectContainsPoint(detectFrame, point);
}

@end
