//
//  LDCViewController.m
//  LDCTransitionAnimatorDemo
//
//  Created by 花生 on 16/3/19.
//  Copyright © 2016年 花生. All rights reserved.
//

#import "LDCViewController.h"
#import "LDCCell.h"
#import "LDCPushViewController.h"
#import "LDCTransitionAnimator.h"

@interface LDCViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,LDCTransitionAnimatorDelegate>{
    UITableView * _tableView;
    LDCCell * selectCell ;
}
@property (nonatomic,strong) LDCTransitionAnimator * animator;

@end

@implementation LDCViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"LDCViewController";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
  //  [_tableView registerClass:[LDCCell class] forCellReuseIdentifier:@"Cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.animator = [[LDCTransitionAnimator alloc]init];
    self.animator.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}


#pragma UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

#pragma UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDCCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LDCCell" owner:self options:nil]lastObject];
    }
    cell.photoImageView.image = [UIImage imageNamed:@"01_L.jpeg"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     self.navigationController.delegate = self;
    NSIndexPath * selectIndexPath = [tableView indexPathForSelectedRow];
    selectCell = [_tableView cellForRowAtIndexPath:selectIndexPath];
    LDCPushViewController * viewController = [[LDCPushViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.pushframe = [selectCell convertRect:selectCell.photoImageView.frame toView:_tableView.superview];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return self.animator;
    }
    return nil;
}

- (UIImageView *)transitionSourceImageView{
    UIImageView * imageView = [[UIImageView alloc]initWithImage:selectCell.photoImageView.image];
    imageView.frame = [selectCell convertRect:selectCell.photoImageView.frame toView:_tableView.superview];
    return imageView;
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
