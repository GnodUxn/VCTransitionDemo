//
//  WXDTransitionFold.m
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/23.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "WXDTransitionFadeFold.h"

#define timeInterval .75

@implementation WXDTransitionFadeFold

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
    
    UIView *transfromView = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? toView : fromView;
    CGAffineTransform transformFromScale = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CGAffineTransformMakeScale(1,0.005) : CGAffineTransformIdentity;
    CGAffineTransform transformToScale = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CGAffineTransformIdentity : CGAffineTransformMakeScale(1,0.005);
    transfromView.transform = transformFromScale;
    [UIView animateWithDuration:timeInterval animations:^{
        fromView.alpha = 0.0;
        transfromView.transform = transformToScale;
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


@end
