//
//  WXDViewControllerTransitioningDelegate.h
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/22.
//  Copyright © 2017年 zonsim. All rights reserved.
//  present/dismiss转场动画协议

#import <Foundation/Foundation.h>
@import UIKit;
#import "WXDViewControllerTansition.h"

@interface WXDViewControllerTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

/**
 *  转场动画类型，使用WXDVCTransitionType
 */
@property (nonatomic, assign) WXDVCTransitionType transitionType;

@end
