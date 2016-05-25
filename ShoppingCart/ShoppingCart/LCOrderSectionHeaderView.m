//
//  LCOrderSectionHeaderView.m
//  ShoppingCart
//
//  Created by MoGo on 16/5/24.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCOrderSectionHeaderView.h"

@interface LCOrderSectionHeaderView ()
@property (nonatomic , strong) UIView *lineView;
@end

@implementation LCOrderSectionHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.sellerIconImageV = [[UIImageView alloc]init];
        self.sellerIconImageV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.sellerIconImageV];
        
        self.sellerNameL = [[UILabel alloc]init];
        [self.contentView addSubview:self.sellerNameL];
        
        self.orderNumberL = [[UILabel alloc]init];
        [self.contentView addSubview:self.orderNumberL];
        self.sellerNameL.font = [UIFont systemFontOfSize:14];
         self.orderNumberL.font = [UIFont systemFontOfSize:14];
        
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.sellerIconImageV.frame = CGRectMake(10, 5,self.frame.size.height - 10, self.frame.size.height - 10);
    self.sellerNameL.frame = CGRectMake(CGRectGetMaxX(self.sellerIconImageV.frame) + 5, 0, 100, self.frame.size.height);
    self.orderNumberL.frame = CGRectMake(self.frame.size.width - 190, 0, 180, self.frame.size.height);
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
