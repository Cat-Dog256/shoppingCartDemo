//
//  LCShoppingModel.h
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCShoppingModel : NSObject
/**
 *  选中
 */
@property (nonatomic , assign) BOOL selectedGood;
/**
 *  显示选中section编辑按钮的view
 */
@property (nonatomic , assign) BOOL showEditingView;
/**
 *  显示选中nav编辑按钮的view
 */
@property (nonatomic , assign) BOOL navEditView;

@property (nonatomic , assign) double price;
@property (nonatomic,  assign) int goodCount;
@property (nonatomic , strong) NSString *desGood;
@end
