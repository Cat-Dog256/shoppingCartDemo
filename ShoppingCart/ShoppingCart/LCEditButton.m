//
//  LCEditButton.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/14.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCEditButton.h"

@implementation LCEditButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"编辑" forState:UIControlStateNormal];
        [self setTitle:@"完成" forState:UIControlStateSelected];

        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)pressButton:(LCEditButton *)button{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
