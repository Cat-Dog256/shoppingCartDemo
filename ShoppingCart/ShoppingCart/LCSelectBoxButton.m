//
//  LCSelectBoxButton.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCSelectBoxButton.h"

@implementation LCSelectBoxButton
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self= [super initWithCoder:aDecoder]) {
        [self setImage:[UIImage imageNamed:@"ic_btn_nor"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ic_btn_sel"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"ic_btn_nor"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ic_btn_sel"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        [self setImage:[UIImage imageNamed:@"ic_btn_nor"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ic_btn_sel"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickButton:(UIButton *)button{
//    button.selected = !button.selected;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
