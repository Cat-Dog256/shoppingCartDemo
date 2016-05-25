//
//  ViewController.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/12.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "ViewController.h"
#import "LCShoppingCartTableViewController.h"
#import "LCMogoShoppingCartTableViewController.h"
@interface ViewController ()
{
    NSArray *shoppingdata;
}
- (IBAction)shoppingCartButton:(UIButton *)sender;
- (IBAction)studyTableButton:(UIButton *)sender;
@end

@implementation ViewController
- (BOOL)prefersStatusBarHidden
{
    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 已经不起作用了
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     shoppingdata =
  
  
                                @[@{@"storeName":@"书店",
                                     @"items":@[@{@"name":@"C语言从入门到放弃",
                                                  @"number":@1,
                                                  @"price":@998},
                                                @{@"name":@"安卓从入门到改行",
                                                  @"number":@1,
                                                  @"price":@298},
                                                @{@"name":@"Java从入门到一生黑",
                                                  @"number":@1,
                                                  @"price":@198},
                                                @{@"name":@"程序猿的基本技能",
                                                  @"number":@1,
                                                  @"price":@98}]},
                                   @{@"storeName":@"男装专卖店",
                                     @"items":@[@{@"name":@"西服",
                                                  @"number":@1,
                                                  @"price":@1999},
                                                @{@"name":@"T恤",
                                                  @"number":@1,
                                                  @"price":@2000},
                                                @{@"name":@"阿迪达斯",
                                                  @"number":@1,
                                                  @"price":@999},
                                                @{@"name":@"森马",
                                                  @"number":@1,
                                                  @"price":@555}]},
                                   @{@"storeName":@"女装专卖",
                                     @"items":@[@{@"name":@"裙子",
                                                  @"number":@1,
                                                  @"price":@100},
                                                @{@"name":@"工作服",
                                                  @"number":@1,
                                                  @"price":@1000},
                                                @{@"name":@"居家服",
                                                  @"number":@1,
                                                  @"price":@3000},
                                                @{@"name":@"雨衣",
                                                  @"number":@1,
                                                  @"price":@58}]},
                                   @{@"storeName":@"文具零售店",
                                     @"items":@[@{@"name":@"钢笔",
                                                  @"number":@1,
                                                  @"price":@58},
                                                @{@"name":@"铅笔",
                                                  @"number":@1,
                                                  @"price":@5},
                                                @{@"name":@"毛笔",
                                                  @"number":@1,
                                                  @"price":@99},
                                                @{@"name":@"画笔",
                                                  @"number":@1,
                                                  @"price":@580}]},
                                   @{@"storeName":@"品牌电脑直销店",
                                     @"items":@[@{@"name":@"Dell电脑",
                                                  @"number":@1,
                                                  @"price":@5800},
                                                @{@"name":@"Mac电脑",
                                                  @"number":@1,
                                                  @"price":@12000},
                                                @{@"name":@"联想电脑",
                                                  @"number":@1,
                                                  @"price":@4890},
                                                @{@"name":@"华硕电脑",
                                                  @"number":@1,
                                                  @"price":@6900}]}];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shoppingCartButton:(UIButton *)sender {
     LCMogoShoppingCartTableViewController *VC = [[LCMogoShoppingCartTableViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    VC.dataArray = shoppingdata;
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)studyTableButton:(UIButton *)sender {
//    LCShoppingCartTableViewController *VC = [[LCShoppingCartTableViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
//    VC.dataArray = shoppingdata;
//    [self presentViewController:nav animated:YES completion:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"我还没学会啊!!!" preferredStyle:UIAlertControllerStyleAlert];
    // 创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSLog(@"注意学习");
    }];
    // 创建按钮
    // 注意取消按钮只能添加一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        // 点击按钮后的方法直接在这里面写
        NSLog(@"注意学习");
    }];
    
        // 创建警告按钮
        UIAlertAction *structlAction = [UIAlertAction actionWithTitle:@"警告" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
            NSLog(@"注意学习");
        }];
    
    // 添加按钮 将按钮添加到UIAlertController对象上
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [alertController addAction:structlAction];

    [self presentViewController:alertController animated:YES completion:nil];
}
@end
