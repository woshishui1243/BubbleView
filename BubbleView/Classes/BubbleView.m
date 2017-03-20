//
//  BubbleView.m
//  AutoCountDemo
//
//  Created by dayu on 17/3/17.
//  Copyright © 2017年 dayu. All rights reserved.
//

#import "BubbleView.h"

typedef void(^CallBack)();

@interface AnimationDelegate : NSObject

@property (nonatomic, copy) CallBack callBack;

@end

@implementation AnimationDelegate

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.callBack) {
        self.callBack();
    }
}

- (void)dealloc {
}

@end

@interface BubbleView () <CAAnimationDelegate>

@end

@implementation BubbleView

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)showOverView:(UIView *)coveredView animation:(BOOL)animation {
    [self showOverView:coveredView];
    if (!animation) { return; }
    // 设定为缩放
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    basicAnimation.duration = 0.25; // 动画持续时间
    basicAnimation.repeatCount = 1; // 重复次数
    basicAnimation.autoreverses = NO; // 动画结束时执行逆动画
    // 缩放倍数
    basicAnimation.fromValue = [NSNumber numberWithFloat:0.1]; // 开始时的倍率
    basicAnimation.toValue = [NSNumber numberWithFloat:1]; // 结束时的倍率
    // 添加动画
    [self.layer addAnimation:basicAnimation forKey:@"scale-layer"];
}

- (void)showOverView:(UIView *)coveredView {
    if (!CGPointEqualToPoint(self.archorPoint, CGPointZero)) {
        CGFloat arrowPosition = (self.arrowPosition ? self.arrowPosition : 0.5);
        CGFloat x = 0;
        CGFloat y = 0;
        switch (self.direction) {
            case BubbleArrorDirectionUp:
                x = self.archorPoint.x - CGRectGetWidth(self.frame) * arrowPosition;
                y = self.archorPoint.y;
                break;
            case BubbleArrorDirectionDown:
                x = self.archorPoint.x - CGRectGetWidth(self.frame) * arrowPosition;
                y = self.archorPoint.y - self.frame.size.height;
                break;
            case BubbleArrorDirectionLeft:
                x = self.archorPoint.x;
                y = self.archorPoint.y - CGRectGetHeight(self.frame) * arrowPosition;
                break;
            default:
                x = self.archorPoint.x - CGRectGetWidth(self.frame);
                y = self.archorPoint.y - CGRectGetHeight(self.frame) * arrowPosition;
                break;
                break;
        }
        
        self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
    }
    [coveredView addSubview:self];
}

- (void)dismissAnimation:(BOOL)animation {
    if (!animation) {  return;  }
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [basicAnimation setValue:@"dismissAnimation" forKey:@"AnimationKey"];
    AnimationDelegate *delegate = [[AnimationDelegate alloc] init];
    __weak typeof(self) weakSelf = self;
    delegate.callBack = ^() {
        [weakSelf dismiss];
    };
    basicAnimation.delegate = delegate;
    basicAnimation.duration = 0.25;
    basicAnimation.repeatCount = 1;
    basicAnimation.autoreverses = NO;
    basicAnimation.fromValue = [NSNumber numberWithFloat:1]; // 开始时的倍率
    basicAnimation.toValue = [NSNumber numberWithFloat:0]; // 结束时的倍率
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:basicAnimation forKey:@"scale-layer"];
}

- (void)dismiss {
    [self removeFromSuperview];
}

#pragma mark - draw rect
- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor clearColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef)context {
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor); //气泡填充色
    [self getDrawPath:context];
}

//气泡背景绘制
- (void)getDrawPath:(CGContextRef)context {
    CGRect rrect = self.bounds;
    CGFloat radius = self.radius;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    
    CGContextSaveGState(context); //保存上下文 1
    CGContextBeginPath(context);
    
    CGFloat arrowWidth = self.arrowWidth ? self.arrowWidth : self.arrowHeight;
    switch (self.direction) {
        case BubbleArrorDirectionUp: {
            x = 0;
            y = CGRectGetMinY(rrect)+self.arrowHeight;
            height = CGRectGetHeight(rrect) - self.arrowHeight;
            width = CGRectGetWidth(rrect);
            CGFloat offsetX = (self.arrowPosition ? self.arrowPosition : 0.5) * width;
            CGContextMoveToPoint(context, offsetX + arrowWidth, y);
            CGContextAddLineToPoint(context, offsetX, y-self.arrowHeight);
            CGContextAddLineToPoint(context, offsetX - arrowWidth, y);
        }
            break;
        case BubbleArrorDirectionDown: {
            x = 0;
            y = CGRectGetMinY(rrect);
            height = CGRectGetHeight(rrect) - self.arrowHeight;
            width = CGRectGetWidth(rrect);
            CGFloat offsetX = (self.arrowPosition ? self.arrowPosition : 0.5) * width;
            CGContextMoveToPoint(context, offsetX + arrowWidth, height);
            CGContextAddLineToPoint(context, offsetX, height+self.arrowHeight);
            CGContextAddLineToPoint(context, offsetX - arrowWidth, height);
        }
            break;
        case BubbleArrorDirectionLeft: {
            x = CGRectGetMinX(rrect)+self.arrowHeight;
            y = CGRectGetMinY(rrect);
            height = CGRectGetHeight(rrect);
            width = CGRectGetWidth(rrect)-self.arrowHeight;
            CGFloat offsetY = (self.arrowPosition ? self.arrowPosition : 0.5) * height;
            CGContextMoveToPoint(context, x, offsetY+arrowWidth);
            CGContextAddLineToPoint(context, CGRectGetMinX(rrect), offsetY);
            CGContextAddLineToPoint(context, x, offsetY-arrowWidth);
        }
            break;
        default:  {
            x = CGRectGetMinX(rrect);
            y = CGRectGetMinY(rrect);
            height = CGRectGetHeight(rrect);
            width = CGRectGetWidth(rrect)-self.arrowHeight;
            CGFloat offsetY = (self.arrowPosition ? self.arrowPosition : 0.5) * height;
            CGContextMoveToPoint(context, width, offsetY+arrowWidth);
            CGContextAddLineToPoint(context, width+self.arrowHeight, offsetY);
            CGContextAddLineToPoint(context, width, offsetY-arrowWidth);
        }
            break;
    }
    
    CGContextFillPath(context); //渲染三角形
    CGContextRestoreGState(context); //还原上下文
    //画圆角矩形
    CGContextMoveToPoint(context, x+radius, y);
    CGContextAddLineToPoint(context, x+width-radius, y);
    CGContextAddArcToPoint(context, x+width, y, x+width, y+radius, radius);
    
    CGContextAddLineToPoint(context, x+width, y+height-radius);
    CGContextAddArcToPoint(context, x+width, y+height, x+width-radius, y+height, radius);
    
    CGContextAddLineToPoint(context, x+radius, y+height);
    CGContextAddArcToPoint(context, x, y+height, x, y+height-radius, radius);
    
    CGContextAddLineToPoint(context, x, y+radius);
    CGContextAddArcToPoint(context, x, y, x+radius, y, radius);
    CGContextClosePath(context);

    CGContextFillPath(context); //渲染圆形
}

@end

