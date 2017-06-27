//
//  WXDScaleTransition.m
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/22.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "WXDTransitionScale.h"

const CGFloat timeInterval = .5;

@implementation WXDTransitionScale

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return timeInterval;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:fromView];
    
    [UIView animateWithDuration:timeInterval animations:^{
        fromView.alpha = 0.0;
        fromView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:YES];
    }];
}

@end
