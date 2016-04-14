//
//  LCShopingTableViewCell.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/12.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCShopingTableViewCell.h"
#import "LCSelectBoxButton.h"

@interface LCShopingTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *SelectBoxButton;
- (IBAction)clickSelectedBoxButton:(LCSelectBoxButton *)sender;

@end

@implementation LCShopingTableViewCell
+ (LCShopingTableViewCell *)loadShoppingCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"LCShopingTableViewCell" owner:self options:nil] lastObject];
}
- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.SelectBoxButton.selected = selected;
    // Configure the view for the selected state
}

- (IBAction)clickSelectedBoxButton:(LCSelectBoxButton *)sender {
    
    if (sender.selected) {
        if ([self.cell_Delegate respondsToSelector:@selector(shopingTableViewCell:didSelectRowAtIndexPath:)]) {
            
            [self.cell_Delegate shopingTableViewCell:self didSelectRowAtIndexPath:self.indextPath];
        }
 
    }else{
        if ([self.cell_Delegate respondsToSelector:@selector(shopingTableViewCell:didDeselectRowAtIndexPath:)]) {
            
            [self.cell_Delegate shopingTableViewCell:self didDeselectRowAtIndexPath:self.indextPath];
        }
    }
}
@end
