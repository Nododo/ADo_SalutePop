//
//  DoorController.m
//  ADo_SalutePop
//
//  Created by 杜 维欣 on 15/8/21.
//  Copyright (c) 2015年 nododo. All rights reserved.
//

#import "DoorController.h"
#import "GoInController.h"
#import "ADo_SalutePresentTransitioning.h"
#import "ADo_SaluteDismissTransitioning.h"

@interface DoorController ()<UIViewControllerTransitioningDelegate>


@end

@implementation DoorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GoInController *goInVC = segue.destinationViewController;
    goInVC.transitioningDelegate = self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[ADo_SalutePresentTransitioning alloc] init];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[ADo_SaluteDismissTransitioning alloc] init];
}

@end
