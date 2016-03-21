//
//  LDCPushViewController.m
//  LDCTransitionAnimatorDemo
//
//  Created by 花生 on 16/3/19.
//  Copyright © 2016年 花生. All rights reserved.
//

#import "LDCPushViewController.h"
#import "LDCTransitionAnimator.h"

@interface LDCPushViewController ()<UINavigationControllerDelegate,ldctransitionAnimatorDataSource>
{
    UIImageView * imageView;
}
@property (weak, nonatomic) IBOutlet UIImageView *animatorView;
@property (strong, nonatomic) LDCTransitionAnimator * transitionAnimator;
@end

@implementation LDCPushViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"LDCPushViewController";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor greenColor];
    self.transitionAnimator = [[LDCTransitionAnimator alloc]init];
    self.transitionAnimator.dataSource = self;
    imageView = [[UIImageView alloc]init];
    imageView.frame = [self.view convertRect:self.animatorView.frame toView:self.view.superview];

//    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionAutoreverse animations:^{
//        self.animatorView.transform = CGAffineTransformMakeScale(1.2, 1.2);
//        .//    } completion:^(BOOL finished) {
//        self.animatorView.transform = CGAffineTransformIdentity;
//        
//    }];
//    UIView animateWithDuration:2.0f delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//        self.animatorView.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    } completion:

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UINavigantionControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return self.transitionAnimator;
    }
    else
        return nil;
}
- (UIImageView *)transitionDataScoureImageView{
    UIImageView * toImageView = [[UIImageView alloc]initWithImage:self.animatorView.image];
    toImageView.frame = [self.view convertRect:self.animatorView.frame toView:self.view.superview];
    return toImageView;
}

- (CGRect)transitionFromViewFrame {
    return self.pushframe;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
