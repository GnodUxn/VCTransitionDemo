//
//  WXDNavigationControllerDelegate.h
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/22.
//  Copyright © 2017年 zonsim. All rights reserved.
//  push/pop转场动画协议

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXDViewControllerTansition.h"

/**
 *  注：此类在控制器中只需创建一次，需用强指针指向，因为在做push/pop操作时还需同一个对象
 */
@interface WXDNavigationControllerDelegate : NSObject <UINavigationControllerDelegate>

/**
 *  转场动画类型，使用WXDVCTransitionType
 */
@property (nonatomic, assign) WXDVCTransitionType transitionType;

@end
