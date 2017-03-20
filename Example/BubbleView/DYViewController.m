//
//  DYViewController.m
//  BubbleView
//
//  Created by woshishui1243 on 03/17/2017.
//  Copyright (c) 2017 woshishui1243. All rights reserved.
//

#import "DYViewController.h"
#import "BubbleView.h"

@interface DYViewController ()

@property (nonatomic, weak) BubbleView *bubbleView;

@property (nonatomic, strong) UIButton *btnView;


@end

@implementation DYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.btnView = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 50, 44)];
    self.btnView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.btnView];
    [self.btnView addTarget:self action:@selector(popBubbleView:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)popBubbleView:(UIButton *)btn {
    BubbleView *bubbleView = [[BubbleView alloc] initWithFrame:CGRectMake(50, 100, 200, 95)];
    //bubbleView.direction = BubbleArrorDirectionLeft;
    //bubbleView.archorPoint = CGPointMake(CGRectGetMaxX(btn.frame), CGRectGetMidY(btn.frame)); //⬇️
    
    //bubbleView.direction = BubbleArrorDirectionRight;
    //bubbleView.archorPoint = CGPointMake(CGRectGetMinX(btn.frame), CGRectGetMidY(btn.frame)); //⬅️
    
    //bubbleView.direction = BubbleArrorDirectionUp;
    //bubbleView.archorPoint = CGPointMake(CGRectGetMidX(btn.frame), CGRectGetMaxY(btn.frame)); //⬆️
    
    bubbleView.direction = BubbleArrorDirectionDown;
    bubbleView.archorPoint = CGPointMake(CGRectGetMidX(btn.frame), CGRectGetMinY(btn.frame)); //➡️
    bubbleView.fillColor = [UIColor colorWithRed:51.000/255 green:51.000/255 blue:51.000/255 alpha:0.9];
    bubbleView.arrowPosition = 0.7;
    bubbleView.radius = 20.0f;
    bubbleView.arrowHeight = 8.0f;
    bubbleView.arrowWidth = 12.0f;
    [bubbleView showOverView:self.view animation:YES];
    self.bubbleView = bubbleView;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.bubbleView) {
        [self.bubbleView dismissAnimation:YES];
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BubbleView *bubbleView = [[BubbleView alloc] initWithFrame:CGRectMake(50, 100, 300, 95)];
        bubbleView.fillColor = [UIColor colorWithRed:51.000/255 green:51.000/255 blue:51.000/255 alpha:0.9];
        bubbleView.arrowPosition = 0.8;
        bubbleView.radius = 20.0f;
        bubbleView.arrowHeight = 8.0f;
        bubbleView.arrowWidth = 12.0f;
        bubbleView.direction = BubbleArrorDirectionUp;
        [bubbleView showOverView:self.view animation:YES];
        self.bubbleView = bubbleView;
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
