//
//  LCOrderHeaderView.h
//  ShoppingCart
//
//  Created by MoGo on 16/5/24.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCOrderHeaderView : UIView

+ (LCOrderHeaderView *)loadOrderHeaderViewWithBuyersName:(NSString *)buyersName buyersPhoneNumber:(NSString *)buyersPhoneNumber;
@end
