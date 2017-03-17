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

@end

@implementation DYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    BubbleView *bubbleView = [[BubbleView alloc] initWithFrame:CGRectMake(50, 100, 300, 95)];
    bubbleView.fillColor = [UIColor colorWithRed:51.000/255 green:51.000/255 blue:51.000/255 alpha:0.9];
    bubbleView.arrowPosition = 0.8;
    bubbleView.radius = 20.0f;
    bubbleView.arrowHeight = 15.0f;
    bubbleView.direction = BubbleArrorDirectionUp;
    [self.view addSubview:bubbleView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
