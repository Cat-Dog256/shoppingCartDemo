//
//  LCSumLabel.m
//  ShoppingCart
//
//  Created by MoGo on 16/5/25.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCSumLabel.h"

@implementation LCSumLabel
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setSumPrice:(double)sumPrice{
    _sumPrice = sumPrice;
    NSString *numberString = [NSString stringWithFormat:@"%.02f",sumPrice];
    NSString *messagePrice = [NSString stringWithFormat:@"合计:￥%@",numberString];
    NSMutableAttributedString *attributexText = [[self class] rangeLabelWithContent:messagePrice hltContentArr:@[numberString] hltColor:[UIColor orangeColor] hltFont:[UIFont systemFontOfSize:16] normolColor:[UIColor blackColor] normalFont:[UIFont systemFontOfSize:16]];
    self.attributedText = attributexText;
    CGRect rect = [attributexText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    self.labelWidth = rect.size.width;
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

@end
