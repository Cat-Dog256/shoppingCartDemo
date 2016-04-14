//
//  LCFooterVIew.h
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCSelectBoxButton.h"

@interface LCFooterView : UIView
+ (LCFooterView *)loadFooterView;
@property (weak, nonatomic) IBOutlet LCSelectBoxButton *allButton;
- (void)pressAllButtonBlock:(void(^)(UIButton *sender))allButtonBloak;
- (void)pressSettlementButtonBlock:(void(^)(UIButton *sender))settlementButtonBloak;
@property (nonatomic , strong) NSString *totalPriceString;
@property (nonatomic , strong) NSString *selectGoodCount;
@property (nonatomic , assign) BOOL showNavEdittingView;
@end
