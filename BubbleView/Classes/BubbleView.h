//
//  BubbleView.h
//  AutoCountDemo
//
//  Created by dayu on 17/3/17.
//  Copyright © 2017年 dayu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BubbleArrorDirectionUp,
    BubbleArrorDirectionDown,
    BubbleArrorDirectionLeft,
    BubbleArrorDirectionRight
} BubbleArrorDirection;

@interface BubbleView : UIView

@property (nonatomic, assign) CGFloat arrowHeight;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) BubbleArrorDirection direction;
@property (nonatomic, assign) CGFloat arrowPosition;

@end