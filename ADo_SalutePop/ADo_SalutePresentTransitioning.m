//
//  ADo_SalutePopTransitioning.m
//  ADo_SalutePop
//
//  Created by 杜 维欣 on 15/8/24.
//  Copyright (c) 2015年 nododo. All rights reserved.
//

#import "ADo_SalutePresentTransitioning.h"
#import "POP.h"
@implementation ADo_SalutePresentTransitioning


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = finalRect;
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toVC.view];
    [containView bringSubviewToFront:toVC.view];
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    scaleAnimation.springBounciness = 20.f;
    scaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished)
    {
        [transitionContext completeTransition:YES];
    };
    [toVC.view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];

//    NSLog(@"%@",NSStringFromCGRect(toVC.view.frame));


}



- (void)test
{
//    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
//    basic.fromValue = [NSValue valueWithCGRect:CGRectMake(kScreenWidth / 2, kScreenHeight / 2, 0, 0)];
//    basic.toValue = [NSValue valueWithCGRect:finalRect];
//    basic.duration = 2.0;
//    basic.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [toVC.view pop_addAnimation:basic forKey:nil];
}

@end
