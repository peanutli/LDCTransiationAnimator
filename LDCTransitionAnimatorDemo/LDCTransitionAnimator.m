//
//  LDCTransitionAnimator.m
//  LDCTransitionAnimatorDemo
//
//  Created by 花生 on 16/3/19.
//  Copyright © 2016年 花生. All rights reserved.
//

#import "LDCTransitionAnimator.h"

@implementation LDCTransitionAnimator

#pragma UIViewControllerAnimatorTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    UIView * alphaView = [[UIView alloc]init];
    alphaView.frame = [transitionContext finalFrameForViewController:toVC];
    alphaView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:alphaView];
    UIImageView * transitionAnimatorView = [[UIImageView alloc]init];
    if([self.delegate respondsToSelector:@selector(transitionSourceImageView)]){
        transitionAnimatorView = [self.delegate transitionSourceImageView];
        [containerView addSubview:transitionAnimatorView];
        [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            transitionAnimatorView.frame = CGRectMake(0, 64,375,300);
            transitionAnimatorView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            alphaView.alpha = 0;
            [transitionContext completeTransition:YES];
            [alphaView removeFromSuperview];
            [transitionAnimatorView removeFromSuperview];
        }];
    }
    else if ([self.dataSource respondsToSelector:@selector(transitionDataScoureImageView)]){
        transitionAnimatorView = [self.dataSource transitionDataScoureImageView];
        [containerView addSubview:transitionAnimatorView];
        [UIView animateWithDuration:1.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alphaView.alpha = 0.5;
            transitionAnimatorView.frame = [self.dataSource transitionFromViewFrame];
            transitionAnimatorView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            alphaView.alpha = 0;
            [transitionContext completeTransition:YES];
            [transitionAnimatorView removeFromSuperview];
            [alphaView removeFromSuperview];
            
        }];
    }
    
}

@end
