//
//  LCShoppingCartTableViewCell.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCShoppingCartTableViewCell.h"
#import "LCSelectBoxButton.h"
#import "LCNormakView.h"
@interface LCShoppingCartTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *navEditingView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet LCNormakView *normalView;
@property (weak, nonatomic) IBOutlet UIView *editingView;
@property (weak, nonatomic) IBOutlet UIButton *SelectBoxButton;

@end

@implementation LCShoppingCartTableViewCell

+ (LCShoppingCartTableViewCell *)loadShoppingCell{
    return [[[NSBundle mainBundle]loadNibNamed:@"LCShoppingCartTableViewCell" owner:self options:nil] lastObject];
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
    // Configure the view for the selected state
}

- (IBAction)clickSelectedBoxButton:(LCSelectBoxButton *)sender {
    
    if (sender.selected == NO) {
        if ([self.cell_Delegate respondsToSelector:@selector(shopingTableViewCell:didSelectRowAtIndexPath:)]) {
            
            [self.cell_Delegate shopingTableViewCell:self didSelectRowAtIndexPath:self.indextPath];
        }
        
    }else{
        if ([self.cell_Delegate respondsToSelector:@selector(shopingTableViewCell:didDeselectRowAtIndexPath:)]) {
            
            [self.cell_Delegate shopingTableViewCell:self didDeselectRowAtIndexPath:self.indextPath];
        }
    }
}
- (void)setGoodModel:(LCShoppingModel *)goodModel{
    _goodModel = goodModel;
    self.SelectBoxButton.selected = goodModel.selectedGood;
    
    if (goodModel.navEditView) {
        self.navEditingView.hidden = NO;
        self.editingView.hidden = YES;
        self.normalView.hidden = YES;
    }else{
        if (goodModel.showEditingView) {
            [self.editingView setHidden:NO];
            [self.normalView setHidden:YES];
        }else{
            [self.editingView setHidden:YES];
            [self.normalView setHidden:NO];
        }

    }
    self.normalView.desString = goodModel.desGood;
    self.normalView.priceString = [NSString stringWithFormat:@"%02.f",goodModel.price];
    self.normalView.countString = [NSString stringWithFormat:@"%d",goodModel.goodCount];
}
@end
