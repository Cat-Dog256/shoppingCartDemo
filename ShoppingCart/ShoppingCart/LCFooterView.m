//
//  LCFooterVIew.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCFooterView.h"
@interface LCFooterView ()
@property (nonatomic , strong) UIView *navEditView;

@property (weak, nonatomic) IBOutlet UIButton *settlementButton;
- (IBAction)clickSettlementButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalPreiceLabel;

- (IBAction)pressAllButton:(LCSelectBoxButton *)sender;
@property (nonatomic , copy) void(^clickAllButton)(UIButton *button);
@property (nonatomic , copy) void(^clcikSettlemen)(UIButton *button);

@property (nonatomic , strong) NSMutableAttributedString *titleAttri;
@end

@implementation LCFooterView
+ (LCFooterView *)loadFooterView{
    return [[[NSBundle mainBundle] loadNibNamed:@"LCFooterView" owner:self options:nil] lastObject];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self.allButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.allButton setBackgroundColor:[UIColor redColor]];
        self.allButton.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
        
        self.navEditView = [[UIView alloc]init];
        self.navEditView.backgroundColor = [UIColor yellowColor];

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = @"点击nav编辑按钮显示的footerView";
        [self.navEditView addSubview:label];
        self.navEditView.hidden = YES;
        [self addSubview:self.navEditView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.navEditView.frame = CGRectMake(CGRectGetMaxX(self.allButton.frame) + 10, 0, self.frame.size.width - CGRectGetMaxX(self.allButton.frame) - 30,self.frame.size.height);
}
- (void)awakeFromNib{
    [self.allButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    self.allButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.totalPriceString = @"0.00";
}
- (void)setTotalPriceString:(NSString *)totalPriceString{
    _totalPriceString = totalPriceString;
    NSMutableAttributedString *textAtt = [[NSMutableAttributedString alloc]initWithAttributedString:self.titleAttri];
    
    NSMutableAttributedString *att = [[self class] rangeLabelWithContent:totalPriceString hltContentArr:@[[totalPriceString substringFromIndex:totalPriceString.length - 2]] hltColor:[UIColor orangeColor] hltFont:[UIFont systemFontOfSize:12] normolColor:[UIColor orangeColor] normalFont:[UIFont systemFontOfSize:16]];
    ;
    [textAtt appendAttributedString:att];
    self.totalPreiceLabel.attributedText = textAtt;
}
- (void)setSelectGoodCount:(NSString *)selectGoodCount{
    _selectGoodCount = selectGoodCount;
    [self.settlementButton setTitle:[NSString stringWithFormat:@"结算(%@)",selectGoodCount] forState:UIControlStateNormal];
}

- (void)setShowNavEdittingView:(BOOL)showNavEdittingView{
    _showNavEdittingView = showNavEdittingView;
    if (showNavEdittingView) {
        self.navEditView.hidden = NO;
    }else{
        self.navEditView.hidden = YES;
    }
}
- (NSMutableAttributedString *)titleAttri{
    if (!_titleAttri) {
        NSString *messagePrice = @"合计:￥";
        _titleAttri = [[self class] rangeLabelWithContent:messagePrice hltContentArr:@[@"￥"] hltColor:[UIColor orangeColor] hltFont:[UIFont systemFontOfSize:16] normolColor:[UIColor blackColor] normalFont:[UIFont systemFontOfSize:14]];
    }
    return _titleAttri;
}
+ (NSMutableAttributedString *)rangeLabelWithContent:(NSString *)content hltContentArr:(NSArray *)hltContentArr hltColor:(UIColor *)hltColor hltFont:(UIFont *)hltFont normolColor:(UIColor *)normolColor normalFont:(UIFont *)normalFont{
    NSMutableArray *hltRangeArr = [NSMutableArray array];
    for (int i = 0;i < hltContentArr.count;i++){
        NSRange range = [content rangeOfString:[hltContentArr objectAtIndex:i]];
        if (range.location != NSNotFound){
            NSValue *rectValue = [NSValue valueWithBytes:&range  objCType:@encode(NSRange)];
            if (rectValue !=nil){
                [hltRangeArr addObject:rectValue];
            }
        }
    }
    NSMutableAttributedString *mutableAttributedString;
    if (content.length){
        mutableAttributedString = [[NSMutableAttributedString alloc]initWithString:content];
    }
    NSMutableArray *rangeTempMutableArr = [NSMutableArray array];
    NSRange zeroRange;
    zeroRange.length = 0;
    zeroRange.location = 0;
    NSValue *zeroRangeValue = [NSValue valueWithBytes:&zeroRange  objCType:@encode(NSRange)];
    [rangeTempMutableArr addObject:zeroRangeValue];
    
    for (int i = 0 ; i < hltRangeArr.count;i++){
        NSRange hltRange = [[hltRangeArr objectAtIndex:i] rangeValue];
        NSRange lastHltRange = [[rangeTempMutableArr lastObject] rangeValue];
        
        // normolRange
        NSRange normolRange;
        normolRange.location = lastHltRange.length + lastHltRange.location;
        normolRange.length = hltRange.location - normolRange.location;
        
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:hltColor range:hltRange];
        [mutableAttributedString addAttribute:NSFontAttributeName value:hltFont range:hltRange];
        
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:normolColor range:normolRange];
        [mutableAttributedString addAttribute:NSFontAttributeName value:normalFont range:normolRange];
        
        NSValue *rectValue = [NSValue valueWithBytes:&hltRange  objCType:@encode(NSRange)];
        [rangeTempMutableArr addObject:rectValue];
    }
    NSRange lastHltRange = [[rangeTempMutableArr lastObject] rangeValue];
    NSRange lastNormolRange;
    lastNormolRange.location = lastHltRange.length + lastHltRange.location;
    lastNormolRange.length = content.length - lastNormolRange.location;
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:normolColor range:lastNormolRange];
    [mutableAttributedString addAttribute:NSFontAttributeName value:normalFont range:lastNormolRange];
    return  mutableAttributedString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)clickSettlementButton:(UIButton *)sender {
    self.clcikSettlemen(sender);
}
- (void)pressSettlementButtonBlock:(void (^)(UIButton *))settlementButtonBloak{
    [self setClcikSettlemen:^(UIButton *button) {
        settlementButtonBloak(button);
    }];
}
- (IBAction)pressAllButton:(LCSelectBoxButton *)sender {
    sender.selected = !sender.selected;
    self.clickAllButton(sender);
}
- (void)pressAllButtonBlock:(void (^)(UIButton *sender))allButtonBloak{
    
    [self setClickAllButton:^(UIButton *sender){
        allButtonBloak(sender);
    }];
}

@end
