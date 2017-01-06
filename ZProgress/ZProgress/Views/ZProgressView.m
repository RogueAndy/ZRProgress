//
//  ZProgressView.m
//  ZProgress
//
//  Created by dazhongge on 2017/1/6.
//  Copyright © 2017年 dazhongge. All rights reserved.
//

#import "ZProgressView.h"

@interface ZProgressView()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) NSTimer *animationTimer;

@property (nonatomic) CGFloat countNumber;

@end

@implementation ZProgressView

- (instancetype)initWithFrame:(CGRect)frame circleFrame:(CGRect)circleFrame strokeColor:(UIColor *)strokeColor {

    if(self = [super initWithFrame:frame]) {
    
        self.circleFrame = circleFrame;
        self.strokeColor = strokeColor;
        [self loadInit];
        [self loadViews];
        [self loadLayout];
        
    }
    
    return self;

}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        [self loadInit];
        [self loadViews];
        [self loadLayout];
        
    }
    
    return self;
    
}

- (void)setCircleFrame:(CGRect)circleFrame {

    _circleFrame = circleFrame;
    [self loadLayout];

}

- (void)setStartAnimation:(BOOL)startAnimation {

    _startAnimation = startAnimation;
    if(_startAnimation) {
    
        [self.animationTimer invalidate];
        self.animationTimer = nil;
        self.shapeLayer.strokeStart = self.strokeStart;
        self.countNumber = self.strokeStart;
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(startAction:) userInfo:nil repeats:YES];
        return;
        
    }
    
    [self.animationTimer invalidate];
    self.animationTimer = nil;
    

}

- (void)setClearAnimation:(BOOL)clearAnimation {

    _clearAnimation = clearAnimation;
    self.shapeLayer.strokeStart = self.strokeStart;
    if(_clearAnimation) {
    
        [self.animationTimer invalidate];
        self.animationTimer = nil;
        self.countNumber = self.strokeEnd;
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(clearAction:) userInfo:nil repeats:YES];
        return;
        
    }
    
    self.shapeLayer.strokeEnd = self.strokeEnd;

}

- (void)setStrokeColor:(UIColor *)strokeColor {

    _strokeColor = strokeColor;
    self.shapeLayer.strokeColor = [self.strokeColor CGColor];

}

- (void)loadInit {

    
    
}

- (void)loadViews {

    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    self.shapeLayer.lineWidth = 75.f;
    self.shapeLayer.strokeColor = [self.strokeColor CGColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.circleFrame];
    self.shapeLayer.path = path.CGPath;
    [self.layer addSublayer:self.shapeLayer];
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0.0;
    
}

- (void)loadLayout {

    self.shapeLayer.frame = self.circleFrame;
    self.shapeLayer.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    [self loadLayout];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.circleFrame];
    self.shapeLayer.path = path.CGPath;
    
}

#pragma mark - selector action

- (void)startAction:(NSTimer *)timer {

    if(self.countNumber >= self.strokeEnd) {
    
        self.shapeLayer.strokeEnd = self.strokeEnd;
        [self.animationTimer invalidate];
        self.animationTimer = nil;
        return;
    
    }
    
    self.shapeLayer.strokeEnd = self.countNumber;
    self.countNumber += 0.001;

}

- (void)clearAction:(NSTimer *)timer {

    if(self.countNumber <= self.strokeStart) {
    
        self.shapeLayer.strokeEnd = self.strokeStart;
        [self.animationTimer invalidate];
        self.animationTimer = nil;
        return;
        
    }
    
    self.shapeLayer.strokeEnd = self.countNumber;
    self.countNumber -= 0.001;

}

@end
