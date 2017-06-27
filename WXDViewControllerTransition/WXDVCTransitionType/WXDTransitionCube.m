//
//  WXDCubeTranistion.m
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/23.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "WXDTransitionCube.h"

#define PERSPECTIVE -1.0 / 200.0
#define ROTATION_ANGLE M_PI_2

@implementation WXDTransitionCube

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    //Create the differents 3D animations
    CATransform3D viewFromTransform;
    CATransform3D viewToTransform;
    
    UIView *generalContentView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    
    viewFromTransform = CATransform3DMakeRotation(ROTATION_ANGLE, 0.0, 1.0, 0.0);
    viewToTransform = CATransform3DMakeRotation(-ROTATION_ANGLE, 0.0, 1.0, 0.0);
    [toView.layer setAnchorPoint:CGPointMake(0, 0.5)];
    [fromView.layer setAnchorPoint:CGPointMake(1, 0.5)];
    
    viewFromTransform.m34 = PERSPECTIVE;
    viewToTransform.m34 = PERSPECTIVE;
    
    toView.layer.transform = viewToTransform;
    
    //Add the to- view
    [generalContentView addSubview:toView];
 
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [generalContentView setTransform:CGAffineTransformMakeTranslation(-generalContentView.frame.size.width/2.0, 0)];
        
        fromView.layer.transform = viewFromTransform;
        toView.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished) {
        
        //Set the final position of every elements transformed
        [generalContentView setTransform:CGAffineTransformIdentity];
        fromView.layer.transform = CATransform3DIdentity;
        toView.layer.transform = CATransform3DIdentity;
        [fromView.layer setAnchorPoint:CGPointMake(0.5f, 0.5f)];
        [toView.layer setAnchorPoint:CGPointMake(0.5f, 0.5f)];
        
        
        if ([transitionContext transitionWasCancelled]) {
            [toView removeFromSuperview];
        } else {
            [fromView removeFromSuperview];
        }
        
        // inform the context of completion
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
