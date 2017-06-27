//
//  WXDViewControllerTansition.h
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/23.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#ifndef WXDViewControllerTansition_h
#define WXDViewControllerTansition_h

/*
 *  WXDVCTransitionType
 */
typedef enum : NSUInteger {
    WXDTransitionTypeScale = 1,
    WXDTransitionTypeCube,
    WXDTransitionTypeBottomLeft,
    WXDTransitionTypeHorizontalFold,
    WXDTransitionTypeVerticalFold,
    WXDTransitionTypeFadeFold,
    WXDTransitionTypeCurveEaseOut,
} WXDVCTransitionType;

#import "WXDNavigationControllerDelegate.h"
#import "WXDViewControllerTransitioningDelegate.h"

#endif /* WXDViewControllerTansition_h */
