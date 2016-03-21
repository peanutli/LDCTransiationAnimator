//
//  LDCTransitionAnimator.h
//  LDCTransitionAnimatorDemo
//
//  Created by 花生 on 16/3/19.
//  Copyright © 2016年 花生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LDCTransitionAnimatorDelegate<NSObject>

@required

- (UIImageView*)transitionSourceImageView;

@end

@protocol ldctransitionAnimatorDataSource <NSObject>

- (UIImageView*)transitionDataScoureImageView;
- (CGRect)transitionFromViewFrame;
@end

@interface LDCTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic,weak)id<LDCTransitionAnimatorDelegate>delegate;
@property (nonatomic,weak)id<ldctransitionAnimatorDataSource>dataSource;

@end
