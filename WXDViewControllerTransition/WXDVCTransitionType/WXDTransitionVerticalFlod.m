//
//  WXDTransitionVerticalFlod.m
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/27.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "WXDTransitionVerticalFlod.h"

#define timeInterval .75f

@interface WXDTransitionVerticalFlod () <CAAnimationDelegate>
{
    CAShapeLayer *maskLayer_left;
    CAShapeLayer *maskLayer_right;
}
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> context;

@end

@implementation WXDTransitionVerticalFlod

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return timeInterval;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _context = transitionContext;
    
    UIView *fromV = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toV = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *transitionView = [transitionContext containerView];
    
    CGFloat height = transitionView.frame.size.height;
    CGFloat width = transitionView.frame.size.width;
    
    UIView *backgroundView;  // 过渡view 只是截图用
    if(_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent){
        [transitionView addSubview:fromV];
        backgroundView = toV;
    }else {
        [transitionView addSubview:toV];
        backgroundView = fromV;
    }
    
    // 截图
    UIGraphicsBeginImageContextWithOptions(toV.frame.size, NO , 0.0);
    [backgroundView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // left
    maskLayer_left = [[CAShapeLayer alloc] init];
    // anchorPoint设置放在frame之前，要不然anchorPoint会影响frame
    maskLayer_left.anchorPoint = CGPointMake(0.0, 0.5);
    maskLayer_left.frame = CGRectMake(0, 0, width / 2, height);
    // 获得上半部分图层
    UIImage *leftImg = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(shotImage.CGImage, CGRectMake(0, 0, CGImageGetWidth(shotImage.CGImage) / 2, CGImageGetHeight(shotImage.CGImage)))];
    // 在layer的图层上添加一个image，contents表示接受内容
    maskLayer_left.contents = (id)leftImg.CGImage;
    [transitionView.layer addSublayer:maskLayer_left];
    
    // left animation
    CABasicAnimation *leftAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D leftFromTransform = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CATransform3DMakeRotation(-M_PI_2, 0, 1, 0) : CATransform3DMakeRotation(0, 0, 1, 0);
    NSValue *leftFromValue = [NSValue valueWithCATransform3D:leftFromTransform];
    [leftAnimation setFromValue:leftFromValue];
    CATransform3D leftToTransform = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CATransform3DMakeRotation(0, 0, 1, 0) : CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    NSValue *leftToValue = [NSValue valueWithCATransform3D:leftToTransform];
    [leftAnimation setToValue:leftToValue];
    [leftAnimation setDelegate:self];
    [leftAnimation setDuration:timeInterval];
    [leftAnimation setRepeatCount:1];
    leftAnimation.fillMode = kCAFillModeBoth;
    [maskLayer_left addAnimation:leftAnimation forKey:nil];
    
    // right
    maskLayer_right = [[CAShapeLayer alloc] init];
    maskLayer_right.anchorPoint = CGPointMake(1.0, 0.5);
    maskLayer_right.frame = CGRectMake(width / 2, 0, width / 2, height);
    // 获得下半部分截图
    UIImage *rightImg = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(shotImage.CGImage, CGRectMake(CGImageGetWidth(shotImage.CGImage) / 2, 0, CGImageGetWidth(shotImage.CGImage) / 2, CGImageGetHeight(shotImage.CGImage)))];
    maskLayer_right.contents = (id)rightImg.CGImage;
    [transitionView.layer addSublayer:maskLayer_right];
    
    // right animation
    CABasicAnimation *rightAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D rightToTransform = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CATransform3DMakeRotation(0, 0, 1, 0) : CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    NSValue *rightToValue = [NSValue valueWithCATransform3D:rightToTransform];
    [rightAnimation setToValue:rightToValue];
    CATransform3D rightFromTransform = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CATransform3DMakeRotation(M_PI_2, 0, 1, 0) : CATransform3DMakeRotation(0, 0, 1, 0);
    NSValue *rightFromValue = [NSValue valueWithCATransform3D:rightFromTransform];
    [rightAnimation setFromValue:rightFromValue];
    [rightAnimation setDelegate:self];
    [rightAnimation setDuration:timeInterval];
    [rightAnimation setRepeatCount:1];
    rightAnimation.fillMode = kCAFillModeBoth;
    [maskLayer_right addAnimation:rightAnimation forKey:nil];
}

#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [[_context containerView] addSubview:[_context viewForKey:UITransitionContextToViewKey]];
    [maskLayer_left removeFromSuperlayer];
    [maskLayer_right removeFromSuperlayer];
    
    //通知 transitionAnimation 完成
    [_context completeTransition:![_context transitionWasCancelled]];
    
    //清除 fromVC 的 mask,这里一定要清除,否则会影响响应者链
    [_context viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [_context viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
