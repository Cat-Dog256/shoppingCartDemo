//
//  LCOrderHeaderView.m
//  ShoppingCart
//
//  Created by MoGo on 16/5/24.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCOrderHeaderView.h"

@interface LCOrderHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneNumberLabel;

@end

@implementation LCOrderHeaderView
+(LCOrderHeaderView *)loadOrderHeaderViewWithBuyersName:(NSString *)buyersName buyersPhoneNumber:(NSString *)buyersPhoneNumber{
    LCOrderHeaderView *headerV = [[[NSBundle mainBundle]loadNibNamed:@"LCOrderHeaderView" owner:self options:nil] lastObject];
    headerV.userNameLabel.text = [NSString stringWithFormat:@"联系人: %@",buyersName];
    headerV.userPhoneNumberLabel.text = [NSString stringWithFormat:@"联系电话: %@",buyersPhoneNumber];
    return headerV;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
       
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
     self.frame = CGRectMake(0, 0, self.frame.size.width, 100);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
