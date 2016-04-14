//
//  LCShoppingHeaderView.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCShoppingHeaderView.h"
#import "LCShoppingModel.h"
#import "LCEditButton.h"

@interface LCShoppingHeaderView ()
@property (nonatomic , strong) LCEditButton *button;
@end

@implementation LCShoppingHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.selectBoxButton = [[LCSelectBoxButton alloc]initWithFrame:CGRectMake(10, 7, 50, 30)];
        [self.selectBoxButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.selectBoxButton];
        self.button = [[LCEditButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 0, 80, 44)];
        
        [self.button addTarget:self action:@selector(clickEditButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button];
    }
    return self;
}

- (void)clickButton:(LCSelectBoxButton *)button{
    if (button.selected == NO) {
        if ([self.header_Delegate respondsToSelector:@selector(shoppingHeaderView:didSelectRowsAtSection:)]) {
            
            [self.header_Delegate shoppingHeaderView:self didSelectRowsAtSection:self.section];
        }
        
    }else{
        if ([self.header_Delegate respondsToSelector:@selector(shoppingHeaderView:didDeselectRowsAtSection:)]) {
            
            [self.header_Delegate shoppingHeaderView:self didDeselectRowsAtSection:self.section];
        }
    }

}

- (void)clickEditButton:(LCEditButton *)button{
    if ([self.header_Delegate respondsToSelector:@selector(shoppingHeaderView:didSelectEditingButton:AtSection:)]) {
        [self.header_Delegate shoppingHeaderView:self didSelectEditingButton:button AtSection:self.section];
    }
}
- (void)setSectionModel:(LCShoppingCartSectionModel *)sectionModel{
    _sectionModel = sectionModel;
    self.button.selected = sectionModel.showEditView;
    self.selectBoxButton.selected = sectionModel.selectedSection;
    
    if (sectionModel.navEditView) {
        self.button.hidden = YES;
    }else{
        self.button.hidden = NO;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
