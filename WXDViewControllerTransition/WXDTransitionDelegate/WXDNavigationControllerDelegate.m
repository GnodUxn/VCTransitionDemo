//
//  WXDNavigationControllerDelegate.m
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/22.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "WXDNavigationControllerDelegate.h"
#import "WXDTransitionScale.h"
#import "WXDTransitionCube.h"
#import "WXDTransitionBottomLeft.h"
#import "WXDTransitionHorizontalFlod.h"
#import "WXDTransitionVerticalFlod.h"
#import "WXDTransitionCurveEaseOut.h"
#import "WXDTransitionFadeFold.h"

@implementation WXDNavigationControllerDelegate

#pragma mark UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
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
                horizontalFlod.transitionType = (operation == UINavigationControllerOperationPush ? TransitionTypePush : TransitionTypePop);
                return horizontalFlod;
            }
            break;
            case WXDTransitionTypeVerticalFold:
            {
                WXDTransitionVerticalFlod *verticalFlod = [WXDTransitionVerticalFlod new];
                verticalFlod.transitionType = (operation == UINavigationControllerOperationPush ? TransitionTypePush : TransitionTypePop);
                return verticalFlod;
            }
                break;
            case WXDTransitionTypeCurveEaseOut:
            {
                WXDTransitionCurveEaseOut *curveEaseOutFlod = [WXDTransitionCurveEaseOut new];
                curveEaseOutFlod.transitionType = (operation == UINavigationControllerOperationPush ? TransitionTypePush : TransitionTypePop);
                return curveEaseOutFlod;
            }
                break;
            case WXDTransitionTypeFadeFold:
            {
                WXDTransitionFadeFold *fadeFlod = [WXDTransitionFadeFold new];
                fadeFlod.transitionType = (operation == UINavigationControllerOperationPush ? TransitionTypePush : TransitionTypePop);
                return fadeFlod;
            }
                break;
            default:
                break;
        }
    }
    return nil;
}

@end
