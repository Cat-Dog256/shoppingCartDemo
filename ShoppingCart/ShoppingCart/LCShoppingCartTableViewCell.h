//
//  LCShoppingCartTableViewCell.h
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCShoppingModel.h"
@class LCShoppingCartTableViewCell;
@protocol LCShoppingCartTableViewCell_delegate <NSObject>

- (void)shopingTableViewCell:(LCShoppingCartTableViewCell *)shopingTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)shopingTableViewCell:(LCShoppingCartTableViewCell *)shopingTableViewCell didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface LCShoppingCartTableViewCell : UITableViewCell
+ (LCShoppingCartTableViewCell *)loadShoppingCell;
@property (nonatomic , strong) LCShoppingModel *goodModel;
@property (nonatomic , assign) id<LCShoppingCartTableViewCell_delegate>cell_Delegate;
@property (nonatomic , strong) NSIndexPath *indextPath;
@end
