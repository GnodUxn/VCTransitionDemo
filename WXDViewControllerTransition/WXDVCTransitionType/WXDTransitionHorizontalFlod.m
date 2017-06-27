//
//  WXDTransitionFlod.m
//  62-ViewController转场动画
//
//  Created by 万旭东 on 17/6/26.
//  Copyright © 2017年 zonsim. All rights reserved.
//

#import "WXDTransitionHorizontalFlod.h"

#define timeInterval .75f

@interface WXDTransitionHorizontalFlod () <CAAnimationDelegate>
{
    CAShapeLayer *maskLayer_top;
    CAShapeLayer *maskLayer_bottom;
}
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> context;

@end

@implementation WXDTransitionHorizontalFlod

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
    
    // top
    maskLayer_top = [[CAShapeLayer alloc] init];
    // anchorPoint设置放在frame之前，要不然anchorPoint会影响frame
    maskLayer_top.anchorPoint = CGPointMake(0.5, 1.0);
    maskLayer_top.frame = CGRectMake(0, 0, width, height/2);
    // 获得上半部分图层
    UIImage *topImg = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(shotImage.CGImage, CGRectMake(0, 0, CGImageGetWidth(shotImage.CGImage), CGImageGetHeight(shotImage.CGImage)/2))];
    // 在layer的图层上添加一个image，contents表示接受内容
    maskLayer_top.contents = (id)topImg.CGImage;
    [transitionView.layer addSublayer:maskLayer_top];
    
    // bottom
    maskLayer_bottom = [[CAShapeLayer alloc] init];
    maskLayer_bottom.anchorPoint = CGPointMake(0.5, 0.0);
    maskLayer_bottom.frame = CGRectMake(0, height/2, width, height/2);
    // 获得下半部分截图
    UIImage *bottomImg = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(shotImage.CGImage, CGRectMake(0, CGImageGetHeight(shotImage.CGImage)/2, CGImageGetWidth(shotImage.CGImage), CGImageGetHeight(shotImage.CGImage)/2))];
    maskLayer_bottom.contents = (id)bottomImg.CGImage;
    [transitionView.layer addSublayer:maskLayer_bottom];
    
    // top animation
    CABasicAnimation *topAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D topFromTransform = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CATransform3DMakeRotation(-M_PI_2, 1, 0, 0) : CATransform3DMakeRotation(0, 1, 0, 0);
    NSValue *topFromValue = [NSValue valueWithCATransform3D:topFromTransform];
    [topAnimation setFromValue:topFromValue];
    CATransform3D topToTransform = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CATransform3DMakeRotation(0, 1, 0, 0) : CATransform3DMakeRotation(-M_PI_2, 1, 0, 0);
    NSValue * topToValue = [NSValue valueWithCATransform3D:topToTransform];
    [topAnimation setToValue:topToValue];
    
    [topAnimation setDelegate:self];
    [topAnimation setDuration:timeInterval];
    [topAnimation setRepeatCount:1];
    topAnimation.fillMode = kCAFillModeBoth;
    
    // bottom animation
    CABasicAnimation *bottomAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D bottomToTransform = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CATransform3DMakeRotation(0, 1, 0, 0) : CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
    NSValue *bottomToValue = [NSValue valueWithCATransform3D:bottomToTransform];
    [bottomAnimation setToValue:bottomToValue];
    CATransform3D bottomFromTransform = (_transitionType == TransitionTypePush || _transitionType == TransitionTypePresent) ? CATransform3DMakeRotation(M_PI_2, 1, 0, 0) : CATransform3DMakeRotation(0, 1, 0, 0);
    NSValue *bottomFromValue = [NSValue valueWithCATransform3D:bottomFromTransform];
    [bottomAnimation setFromValue:bottomFromValue];
    [bottomAnimation setDelegate:self];
    [bottomAnimation setDuration:timeInterval];
    [bottomAnimation setRepeatCount:1];
    bottomAnimation.fillMode = kCAFillModeBoth;
    
    [maskLayer_top addAnimation:topAnimation forKey:nil];
    [maskLayer_bottom addAnimation:bottomAnimation forKey:nil];
}

#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [[_context containerView] addSubview:[_context viewForKey:UITransitionContextToViewKey]];
    [maskLayer_top removeFromSuperlayer];
    [maskLayer_bottom removeFromSuperlayer];
    
    //通知 transitionAnimation 完成
    [_context completeTransition:![_context transitionWasCancelled]];
    
    //清除 fromVC 的 mask,这里一定要清除,否则会影响响应者链
    [_context viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [_context viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}


@end
