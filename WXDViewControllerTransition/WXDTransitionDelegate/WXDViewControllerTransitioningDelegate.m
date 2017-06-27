//
//  WXDViewControllerTransitioningDelegate.m
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/22.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "WXDViewControllerTransitioningDelegate.h"
#import "WXDTransitionScale.h"
#import "WXDTransitionCube.h"
#import "WXDTransitionBottomLeft.h"
#import "WXDTransitionCurveEaseOut.h"
#import "WXDTransitionFadeFold.h"
#import "WXDTransitionHorizontalFlod.h"
#import "WXDTransitionVerticalFlod.h"

@implementation WXDViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if (self.transitionType > 0) {
        switch (self.transitionType) {
            case WXDTransitionTypeScale:
                return [WXDTransitionScale new];
                break;
            case WXDTransitionTypeCube:
                return [WXDTransitionCube new];
                break;
            case WXDTransitionTypeBottomLeft:
                return [WXDTransitionBottomLeft new];
                break;
            case WXDTransitionTypeHorizontalFold:
            {
                WXDTransitionHorizontalFlod *horizontalFlod = [WXDTransitionHorizontalFlod new];
                horizontalFlod.transitionType = TransitionTypePresent;
                return horizontalFlod;
            }
            break;
            case WXDTransitionTypeCurveEaseOut:
            {
                WXDTransitionCurveEaseOut *curveEaseOutFlod = [WXDTransitionCurveEaseOut new];
                curveEaseOutFlod.transitionType = TransitionTypePresent;
                return curveEaseOutFlod;
            }
                break;
            case WXDTransitionTypeFadeFold:
            {
                WXDTransitionFadeFold *fadeFlod = [WXDTransitionFadeFold new];
                fadeFlod.transitionType = TransitionTypePresent;
                return fadeFlod;
            }
                break;
            case WXDTransitionTypeVerticalFold:
            {
                WXDTransitionVerticalFlod *verticalFlod = [WXDTransitionVerticalFlod new];
                verticalFlod.transitionType = TransitionTypePresent;
                return verticalFlod;
            }
                break;
            default:
                break;
        }
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if (self.transitionType) {
        switch (self.transitionType) {
            case WXDTransitionTypeScale:
                return [WXDTransitionScale new];
                break;
            case WXDTransitionTypeCube:
                return [WXDTransitionCube new];
                break;
            case WXDTransitionTypeBottomLeft:
                return [WXDTransitionBottomLeft new];
                break;
            case WXDTransitionTypeCurveEaseOut:
            {
                WXDTransitionCurveEaseOut *curveEaseOutFlod = [WXDTransitionCurveEaseOut new];
                curveEaseOutFlod.transitionType = TransitionTypeDismiss;
                return curveEaseOutFlod;
            }
                break;
            case WXDTransitionTypeFadeFold:
            {
                WXDTransitionFadeFold *fadeFlod = [WXDTransitionFadeFold new];
                fadeFlod.transitionType = TransitionTypeDismiss;
                return fadeFlod;
            }
                break;
            case WXDTransitionTypeHorizontalFold:
            {
                WXDTransitionHorizontalFlod *horizontalFlod = [WXDTransitionHorizontalFlod new];
                horizontalFlod.transitionType = TransitionTypeDismiss;
                return horizontalFlod;
            }
            break;
            case WXDTransitionTypeVerticalFold:
            {
                WXDTransitionVerticalFlod *verticalFlod = [WXDTransitionVerticalFlod new];
                verticalFlod.transitionType = TransitionTypeDismiss;
                return verticalFlod;
            }
                break;
            default:
                break;
        }
    }
    return nil;
}

@end
