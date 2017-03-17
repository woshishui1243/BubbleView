//
//  BubbleView.m
//  AutoCountDemo
//
//  Created by dayu on 17/3/17.
//  Copyright © 2017年 dayu. All rights reserved.
//

#import "BubbleView.h"

@interface BubbleView ()

@end

@implementation BubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
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
    
    switch (self.direction) {
        case BubbleArrorDirectionUp: {
            x = 0;
            y = CGRectGetMinY(rrect)+self.arrowHeight;
            height = CGRectGetHeight(rrect) - self.arrowHeight;
            width = CGRectGetWidth(rrect);
            CGFloat offsetX = (self.arrowPosition ? self.arrowPosition : 0.5) * width;
            CGContextMoveToPoint(context, offsetX + self.arrowHeight, y);
            CGContextAddLineToPoint(context, offsetX, y-self.arrowHeight);
            CGContextAddLineToPoint(context, offsetX - self.arrowHeight, y);
        }
            break;
        case BubbleArrorDirectionDown: {
            x = 0;
            y = CGRectGetMinY(rrect);
            height = CGRectGetHeight(rrect) - self.arrowHeight;
            width = CGRectGetWidth(rrect);
            CGFloat offsetX = (self.arrowPosition ? self.arrowPosition : 0.5) * width;
            CGContextMoveToPoint(context, offsetX + self.arrowHeight, height);
            CGContextAddLineToPoint(context, offsetX, height+self.arrowHeight);
            CGContextAddLineToPoint(context, offsetX - self.arrowHeight, height);
        }
            break;
        case BubbleArrorDirectionLeft: {
            x = CGRectGetMinX(rrect)+self.arrowHeight;
            y = CGRectGetMinY(rrect);
            height = CGRectGetHeight(rrect);
            width = CGRectGetWidth(rrect)-self.arrowHeight;
            CGFloat offsetY = (self.arrowPosition ? self.arrowPosition : 0.5) * height;
            CGContextMoveToPoint(context, x, offsetY+self.arrowHeight);
            CGContextAddLineToPoint(context, CGRectGetMinX(rrect), offsetY);
            CGContextAddLineToPoint(context, x, offsetY-self.arrowHeight);
        }
            break;
        default:  {
            x = CGRectGetMinX(rrect);
            y = CGRectGetMinY(rrect);
            height = CGRectGetHeight(rrect);
            width = CGRectGetWidth(rrect)-self.arrowHeight;
            CGFloat offsetY = (self.arrowPosition ? self.arrowPosition : 0.5) * height;
            CGContextMoveToPoint(context, width, offsetY+self.arrowHeight);
            CGContextAddLineToPoint(context, width+self.arrowHeight, offsetY);
            CGContextAddLineToPoint(context, width, offsetY-self.arrowHeight);
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
    
    
    CGContextFillPath(context); //渲染圆形
    CGContextClosePath(context);
}

@end
