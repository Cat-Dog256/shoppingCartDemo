//
//  LCShoppingHeaderView.h
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCSelectBoxButton.h"
#import "LCShoppingCartSectionModel.h"
@class LCShoppingHeaderView;

@protocol LCShoppingHeaderView_delegate<NSObject>

- (void)shoppingHeaderView:(LCShoppingHeaderView *)shoppingHeaderView didSelectRowsAtSection:(NSInteger)section;
- (void)shoppingHeaderView:(LCShoppingHeaderView *)shoppingHeaderView didDeselectRowsAtSection:(NSInteger)section;
@optional;
- (void)shoppingHeaderView:(LCShoppingHeaderView *)shoppingHeaderView didSelectEditingButton:(UIButton *)editingButton AtSection:(NSInteger)section;
@end

@interface LCShoppingHeaderView : UITableViewHeaderFooterView
@property (nonatomic , assign) NSInteger section;
@property (nonatomic , strong) LCShoppingCartSectionModel *sectionModel;
@property (nonatomic, assign) id<LCShoppingHeaderView_delegate>header_Delegate;
@property (nonatomic , strong) LCSelectBoxButton *selectBoxButton;
@end
