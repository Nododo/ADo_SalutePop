//
//  ADo_SaluteDismissTransitioning.m
//  ADo_SalutePop
//
//  Created by 杜 维欣 on 15/8/25.
//  Copyright (c) 2015年 nododo. All rights reserved.
//

#import "ADo_SaluteDismissTransitioning.h"
#import "POP.h"

@implementation ADo_SaluteDismissTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    
    
    
    UIView *containerView = [transitionContext containerView];
    toVC.view.frame = finalRect;
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];

    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    scaleAnimation.springBounciness = 20.f;
   
    scaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished)
    {
        [transitionContext completeTransition:YES];
    };
    [fromVC.view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
}
@end
