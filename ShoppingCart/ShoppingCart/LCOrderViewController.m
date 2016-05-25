//
//  LCOrderViewController.m
//  ShoppingCart
//
//  Created by MoGo on 16/5/24.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCOrderViewController.h"
#import "LCOrderHeaderView.h"
#import "LCOrderSectionHeaderView.h"
#import "LCOrderSectionFooterView.h"
#import "LCSumLabel.h"
@interface LCOrderViewController ()<UITableViewDataSource , UITableViewDelegate>
- (IBAction)makeSuerTheOrderAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet LCSumLabel *bottomSumLabel;
@property (weak, nonatomic) IBOutlet UITableView *orderTableView;
/**
 *  键盘升起的currentLeaveMessageTextFiled相对屏幕的Y值,判断是否被键盘遮挡
 */
@property (nonatomic , assign) CGFloat currentLeaveMessageTextFiled_Y;
/**
 *  currentLeaveMessageTextFiled所在的section的偏移量
 */
@property (nonatomic , assign) CGFloat currentLeaveMessageTextFiled_offsetY;
@end

@implementation LCOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderTableView.tableHeaderView = [LCOrderHeaderView loadOrderHeaderViewWithBuyersName:@"茉莉清茶" buyersPhoneNumber:@"15703602508"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.orderTableView addGestureRecognizer:tap];
#warning 订单总价
    self.bottomSumLabel.sumPrice = 10000;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
       // Do any additional setup after loading the view from its nib.
}
- (void)keyboardWillShow:(NSNotification *)notifi{
   CGRect rect = [notifi.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardH = rect.size.height;
    if (self.currentLeaveMessageTextFiled_Y > self.view.frame.size.height - keyboardH) {
        [UIView animateWithDuration:0.26 animations:^{
             self.orderTableView.contentOffset = CGPointMake(0, self.currentLeaveMessageTextFiled_offsetY);
        }];
       
    
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"确认订单";
    return cell;
    
}

#pragma mark --tableView viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LCOrderSectionHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHeaderView"];
    if (!sectionHeaderView) {
        sectionHeaderView = [[LCOrderSectionHeaderView alloc]initWithReuseIdentifier:@"sectionHeaderView"];
    }
    sectionHeaderView.sellerIconImageV.image = [UIImage imageNamed:@"666"];
    sectionHeaderView.sellerNameL.text = @"卖家昵称";
    
    int random = arc4random()%10000000;
    sectionHeaderView.orderNumberL.text = [NSString stringWithFormat:@"订单号: %d",random];
    return sectionHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}


#pragma mark --tableView viewForFooterInSection
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LCOrderSectionFooterView *sectionFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionFooterView"];
        if (!sectionFooterView) {
            sectionFooterView = [[LCOrderSectionFooterView alloc]initWithReuseIdentifier:@"sectionFooterView"];
        }
    [sectionFooterView setSumPrice:9998.98 goodCount:100];
    sectionFooterView.section = section;
    [sectionFooterView leaveMessageText:^(NSString *leaveMessageText, NSInteger section) {
        NSLog(@"%@ -- %lu",leaveMessageText , (long)section);
          }];
    
    /**
     *  键盘升起*/
    [sectionFooterView leaveMessageTextFiledShouldBeginEditing:^(UITextField *curentleaveMessageTextFiled, NSInteger section) {
        
        /**
         *  转为相对屏幕的坐标
         */
        CGRect rectTowindow = [curentleaveMessageTextFiled convertRect:curentleaveMessageTextFiled.frame toView:self.view];
        self.currentLeaveMessageTextFiled_Y = CGRectGetMaxY(rectTowindow);
        
        /**
         *  获取当前section的相对tableView的坐标
         */
        CGRect sectionRect = [self.orderTableView rectForSection:section];
        
        self.currentLeaveMessageTextFiled_offsetY = CGRectGetMinY(sectionRect) - 44;
        }];
    
    return sectionFooterView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 98;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    /**
     *  键盘升起时候偏移量超过最大的偏移量时偏移到底部
     */
    if (self.orderTableView.contentOffset.y > self.orderTableView.contentSize.height - self.view.frame.size.height) {
        [UIView animateWithDuration:0.26 animations:^{
            self.orderTableView.contentOffset = CGPointMake(0, self.orderTableView.contentSize.height - self.view.frame.size.height);
 
        }];
    }
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark --makeSuerTheOrderAction 确认订单
- (IBAction)makeSuerTheOrderAction:(UIButton *)sender {
    NSLog(@"确认订单");
}
@end
