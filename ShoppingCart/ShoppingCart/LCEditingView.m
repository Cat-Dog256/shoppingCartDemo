//
//  LCEditingView.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/14.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCEditingView.h"

@implementation LCEditingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSString *Text = @"我是点击了section头部的编辑按钮出现的View";
    [Text drawInRect:rect withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18] , NSForegroundColorAttributeName : [UIColor redColor]}];
}


@end
