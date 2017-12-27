//
//  ZFBatteryView.m
//  ZFBatteryV
//
//  Created by 张帆 on 2017/12/21.
//  Copyright © 2017年 张帆. All rights reserved.
//

#import "ZFBatteryView.h"

#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)
@interface ZFBatteryView ()
@property (nonatomic, strong) CAShapeLayer *chargeLayer;
@property (nonatomic, strong) CAShapeLayer *contentLayer;
@end

@implementation ZFBatteryView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView {
    
    self.contentLayer = [[CAShapeLayer alloc] init];
    [self.layer addSublayer:self.contentLayer];
    self.chargeLayer = [[CAShapeLayer alloc] init];
    self.chargeLayer.hidden = YES;
    [self.layer addSublayer:self.chargeLayer];
    [self setBackgroundColor:[UIColor clearColor]];
}
const CGFloat margin = 2.0f;
const CGFloat radius = 1.5f;
const CGFloat w = 26;
const CGFloat h = 12;
- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] set];
    
    UIBezierPath *board = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0 , 0, w, h) cornerRadius:3];
    board.lineWidth = 1;
    [board stroke];
    
    UIBezierPath *contentPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(margin, margin, w - margin * 2, h - margin * 2) cornerRadius:radius];
    self.contentLayer.path = contentPath.CGPath;
    self.contentLayer.fillColor = [UIColor whiteColor].CGColor;
    CGFloat wi =  w + 2;
    UIBezierPath *tou = [UIBezierPath bezierPathWithArcCenter:CGPointMake(wi , h * 0.5) radius:rect.size.height * 0.15 startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(270) clockwise:NO];
    
    [tou fill];
    
    wi += 8;
    CGFloat width = 2.5f;
    CGFloat height = h ;
    CGPoint center = CGPointMake(w / 2.f, h / 2.f);
    float hPercent = .40f;
    UIBezierPath *chargePath = [UIBezierPath bezierPath];
    [chargePath moveToPoint:CGPointMake( wi +  width - 1, center.y + height * -hPercent)];
    [chargePath addLineToPoint:CGPointMake(wi - width, center.y + 0.f)];
    [chargePath addLineToPoint:CGPointMake(wi + width, center.y + 0.f)];
    [chargePath addLineToPoint:CGPointMake(wi - width + 1, center.y + height * hPercent)];
    [chargePath closePath];
    self.chargeLayer.path = chargePath.CGPath;
    self.chargeLayer.fillColor = [UIColor whiteColor].CGColor;
}
- (void)setCharging:(BOOL)charging {
    _charging = charging;
    if (_charging) {
        self.chargeLayer.hidden = NO;
        self.contentLayer.fillColor = [UIColor colorWithRed:111.0 / 255.0 green:215.0 / 255.0 blue:106.0 / 255.0 alpha:1].CGColor;
        self.contentLayer.strokeEnd = .5f;
    } else {
        self.chargeLayer.hidden = YES;
        self.contentLayer.fillColor = [UIColor whiteColor].CGColor;
        self.contentLayer.strokeEnd = .9f;
    }
}
- (void)setPercent:(int)percent {
    if (_percent != percent) {
        _percent = percent;
        CGFloat wii = 22 * percent/100.0;
        UIBezierPath *contentPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(2.0f, 2.0f, wii, 12 - 2.0f * 2) cornerRadius:1.5f];
        self.contentLayer.path = contentPath.CGPath;
        if (percent < 10) {
            if (!self.lowPower) {
                if ([self.delegate respondsToSelector:@selector(zf_batteryLowPower)]) {
                    [self.delegate zf_batteryLowPower];
                }
            }
            self.lowPower = YES;
            self.contentLayer.fillColor = [UIColor redColor].CGColor;
        } else {
            self.lowPower = NO;
            if (!_charging) {
                self.contentLayer.fillColor = [UIColor whiteColor].CGColor;
            } else {
                self.contentLayer.fillColor = [UIColor colorWithRed:111.0 / 255.0 green:215.0 / 255.0 blue:106.0 / 255.0 alpha:1].CGColor;
            }
        }
    }
    
}

@end
