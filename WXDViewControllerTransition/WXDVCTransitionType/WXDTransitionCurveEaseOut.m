//
//  WXDDismissTransition.m
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/23.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "WXDTransitionCurveEaseOut.h"

#define timeInterval .75

@implementation WXDTransitionCurveEaseOut

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return timeInterval;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *transitionView = [transitionContext containerView];
    [transitionView addSubview:toVC.view];
    
    CGFloat height = transitionView.frame.size.height;
    
    CGRect finalPosition = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CGRectOffset(finalPosition, 0, height) : CGRectOffset(finalPosition, 0, -height);
    [UIView animateWithDuration:timeInterval delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toVC.view.frame = finalPosition;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
