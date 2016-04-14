//
//  LCShoppingCartSectionModel.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCShoppingCartSectionModel.h"
#import "LCShoppingModel.h"
@implementation LCShoppingCartSectionModel

- (NSString *)description{
    return [NSString stringWithFormat:@"%p -- %@",self , self.goodModelArray];
}
- (instancetype)init{
    if (self = [super init]) {
        self.goodModelArray = [NSMutableArray array];
    }
    return self;
}

- (void)setNavEditView:(BOOL)navEditView{
    _navEditView = navEditView;
    for (LCShoppingModel *model in self.goodModelArray) {
        model.navEditView = navEditView;
    }
}
@end
