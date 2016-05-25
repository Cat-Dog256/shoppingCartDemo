//
//  LCOrderSectionFooterView.h
//  ShoppingCart
//
//  Created by MoGo on 16/5/24.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCOrderSectionFooterView : UITableViewHeaderFooterView
@property (nonatomic , assign)  NSInteger section;
- (void)setSumPrice:(double)sumPrice goodCount:(int)goodCount;
- (void)leaveMessageText:(void(^)(NSString *leaveMessageText , NSInteger section))leaveMessageTextBlock;
- (void)leaveMessageTextFiledShouldBeginEditing:(void(^)(UITextField *curentleaveMessageTextFiled , NSInteger section))curentleaveMessageTextFiled;
@end
