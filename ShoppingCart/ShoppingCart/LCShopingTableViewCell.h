//
//  LCShopingTableViewCell.h
//  ShoppingCart
//
//  Created by MoGo on 16/4/12.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCShopingTableViewCell;
@protocol LCShopingTableViewCell_delegate <NSObject>

- (void)shopingTableViewCell:(LCShopingTableViewCell *)shopingTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)shopingTableViewCell:(LCShopingTableViewCell *)shopingTableViewCell didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface LCShopingTableViewCell : UITableViewCell
+ (LCShopingTableViewCell *)loadShoppingCell;

@property (nonatomic , assign) id<LCShopingTableViewCell_delegate>cell_Delegate;
@property (nonatomic , strong) NSIndexPath *indextPath;
@end
