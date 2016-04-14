//
//  LCNormakView.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/14.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCNormakView.h"

@interface LCNormakView ()
@property (nonatomic , strong) UILabel *descrieLabel;
@property (nonatomic , strong) UILabel *priceLabel;
@property (nonatomic , strong) UILabel *countLabel;
@end

@implementation LCNormakView
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.descrieLabel = [[UILabel alloc]init];
        
        [self addSubview:self.descrieLabel];
        
        
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.textColor = [UIColor orangeColor];
        [self addSubview:self.priceLabel];
        
        
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.countLabel];
        
        self.descrieLabel.font = [UIFont systemFontOfSize:16];
        self.priceLabel.font = [UIFont systemFontOfSize:16];
        self.countLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.descrieLabel.frame = CGRectMake(0, 0, self.frame.size.width, 30);
     self.priceLabel.frame = CGRectMake(0, self.frame.size.height - 20, 80, 20);
    self.countLabel.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height - 20, 60, 20);
}

- (void)setDesString:(NSString *)desString{
    self.descrieLabel.text = desString;
}
- (void)setPriceString:(NSString *)priceString{
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",priceString];
}
- (void)setCountString:(NSString *)countString{
    self.countLabel.text = [NSString stringWithFormat:@"×%@",countString];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
