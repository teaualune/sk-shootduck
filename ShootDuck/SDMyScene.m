//
//  SDMyScene.m
//  ShootDuck
//
//  Created by Teaualune Tseng on 13/7/28.
//  Copyright (c) 2013年 Teaualune Tseng. All rights reserved.
//

#import "SDMyScene.h"

#import "SDShootDuckGame.h"
#import "SDDuck.h"

typedef enum {
    begin,
    running
} GameState;

@interface SDMyScene ()

@property (nonatomic) GameState state;

@property (nonatomic, strong) SKLabelNode *startLabel;

@property (nonatomic, strong) SDShootDuckGame *game;

@property (nonatomic, strong) NSTimer *addDuckTimer;

@property (nonatomic, strong) SKLabelNode *timeLabel;

@property (nonatomic, strong) SKLabelNode *scoreLabel;

- (void)beginStateTouch:(CGPoint)location withEvent:(UIEvent *)event;

- (void)runningStateTouch:(CGPoint)location withEvent:(UIEvent *)event;

- (void)addDuck:(NSTimer *)timer;

- (void)updateGame:(NSTimer *)timer;

@end

@implementation SDMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

        _state = begin;

        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.startLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        self.startLabel.text = @"Start";
        self.startLabel.fontSize = 30;
        self.startLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        [self addChild:self.startLabel];

        _game = [[SDShootDuckGame alloc] init];
        _timeLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _timeLabel.text = [NSString stringWithFormat:@"Time: %ld", (long) _game.remainingTime];
        _timeLabel.fontSize = 16;
        _timeLabel.position = CGPointMake(30, 30);
        [self addChild:_timeLabel];

        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _scoreLabel.text = @"Score: 0";
        _scoreLabel.fontSize = 16;
        _scoreLabel.position = CGPointMake(100, 30);
        [self addChild:_scoreLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    CGPoint location = [[touches anyObject] locationInNode:self];

    switch (self.state) {
        case begin: {
            [self beginStateTouch:location withEvent:event];
            break;
        }
        case running: {
            [self runningStateTouch:location withEvent:event];
            break;
        }
        default:
            break;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (self.state == running) {
        self.timeLabel.text = [NSString stringWithFormat:@"Time: %ld", (long) self.game.remainingTime];

        if (self.game.remainingTime < 0) {
            // game over
            [self.game.gameTimer invalidate];
            [self.addDuckTimer invalidate];
            for (SDDuck *duck in self.game.ducks) {
                [duck.spriteNode removeFromParent];
            }
            [self.game.ducks removeAllObjects];
            self.startLabel.hidden = NO;
            self.scoreLabel.fontColor = [SKColor redColor];
            self.state = begin;
        }
    }
}

- (void)beginStateTouch:(CGPoint)location withEvent:(UIEvent *)event
{
    if ([self.startLabel containsPoint:location]) {
        self.startLabel.hidden = YES;
        self.state = running;
        NSLog(@"begin");
        self.addDuckTimer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(addDuck:) userInfo:Nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.addDuckTimer forMode:NSDefaultRunLoopMode];

        self.game.gameTimer = [NSTimer timerWithTimeInterval:1 / 60.0 target:self selector:@selector(updateGame:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.game.gameTimer forMode:NSDefaultRunLoopMode];

        self.scoreLabel.fontColor = [SKColor whiteColor];
        self.scoreLabel.text = @"Score: 0";
        [self.game reset];
    }
}

- (void)runningStateTouch:(CGPoint)location withEvent:(UIEvent *)event
{
    for (SDDuck *duck in self.game.ducks) {
        if ([duck containsPoint:location]) {
            // hit a duck!
            self.game.score += duck.score;
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
            [duck.spriteNode removeFromParent];
            [self.game.ducks removeObject:duck];
            break;
        }
    }
}

- (void)addDuck:(NSTimer *)timer
{
    SDDuck *duck = [[SDDuck alloc] init];
    [self.game.ducks addObject:duck];
    [self addChild:duck.spriteNode];
}

- (void)updateGame:(NSTimer *)timer
{
    [self.game updateTime:timer];
}

@end
