//
//  LCShoppingCartSectionModel.h
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LCShoppingCartSectionModel : NSObject
/**
 *  选中一组
 */
@property (nonatomic , assign) BOOL selectedSection;
/**
 *  显示选中section编辑按钮的view
 */
@property (nonatomic , assign) BOOL showEditView;
/**
 *  显示选中nav编辑按钮的view
 */
@property (nonatomic , assign) BOOL navEditView;
@property (nonatomic , strong) NSMutableArray *goodModelArray;
@end
