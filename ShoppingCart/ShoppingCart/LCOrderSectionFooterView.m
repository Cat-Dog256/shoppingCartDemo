//
//  LCOrderSectionFooterView.m
//  ShoppingCart
//
//  Created by MoGo on 16/5/24.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCOrderSectionFooterView.h"
#import "LCSumLabel.h"
@interface LCOrderSectionFooterView ()<UITextFieldDelegate>
@property (nonatomic , strong) LCSumLabel *sumLabel;
@property (nonatomic , strong) UILabel *countLabel;
@property (nonatomic , strong) UITextField *leaveMessageTextFiled;
@property (nonatomic , strong) UIView *lineViewTop;
@property (nonatomic , strong) UIView *lineViewOne;
@property (nonatomic , strong) UIView *lineViewTwo;


@property (nonatomic , copy) void(^leaveMessageTextFiledBlock)(NSString *text ,NSInteger section);
@property (nonatomic , copy) void(^leaveMessageTextFiledShouldBeginEditingBlock)(UITextField *textFiled , NSInteger section);
@end

@implementation LCOrderSectionFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        
        self.sumLabel = [[LCSumLabel alloc]init];
        [self.contentView addSubview:self.sumLabel];
       
        
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.countLabel];
        
        
        self.leaveMessageTextFiled = [[UITextField alloc]init];
        self.leaveMessageTextFiled.backgroundColor = [UIColor whiteColor];
        self.leaveMessageTextFiled.placeholder = @"选填,可填写你与卖家达成一致的要求";
        self.leaveMessageTextFiled.font = [UIFont systemFontOfSize:14];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"留言备注:";
        self.leaveMessageTextFiled.leftView = label;
        self.leaveMessageTextFiled.leftViewMode = UITextFieldViewModeAlways;
        self.leaveMessageTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:self.leaveMessageTextFiled];
        self.leaveMessageTextFiled.delegate = self;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledDidChange:) name:UITextFieldTextDidChangeNotification object:nil];;
        
        
        self.lineViewTop = [self loadLineView];
        [self.contentView addSubview:_lineViewTop];
        
        self.lineViewOne = [self loadLineView];
        [self.contentView addSubview:self.lineViewOne];
        
        self.lineViewTwo = [self loadLineView];
        [self.contentView addSubview:self.lineViewTwo];
    }
    return self;
}
- (void)setSumPrice:(double)sumPrice goodCount:(int)goodCount{
    self.sumLabel.sumPrice = sumPrice;
    self.countLabel.text = [NSString stringWithFormat:@"共%d件商品",goodCount];
    dispatch_async(dispatch_get_main_queue(), ^{
    self.sumLabel.frame = CGRectMake(self.frame.size.width - self.sumLabel.labelWidth - 10, 0, self.sumLabel.labelWidth, 44);
    [self.countLabel sizeToFit];
    self.countLabel.frame = CGRectMake(self.sumLabel.frame.origin.x - 10 - self.countLabel.frame.size.width, 0, self.countLabel.frame.size.width, 44);
    });
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.leaveMessageTextFiled.frame = CGRectMake(0, 44, self.frame.size.width, 44);
    self.lineViewTop.frame = CGRectMake(0, 0, self.frame.size.width, 1);
     self.lineViewOne.frame = CGRectMake(0,43, self.frame.size.width, 1);
     self.lineViewTwo.frame = CGRectMake(0, 88, self.frame.size.width, 10);
}

- (UIView *)loadLineView{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}
- (void)textFiledDidChange:(NSNotification *)nitifi{
    self.leaveMessageTextFiledBlock(self.leaveMessageTextFiled.text , self.section);
}
- (void)leaveMessageText:(void (^)(NSString *, NSInteger))leaveMessageTextBlock{
    [self setLeaveMessageTextFiledBlock:^(NSString *text, NSInteger section) {
        leaveMessageTextBlock(text , section);
    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.leaveMessageTextFiledShouldBeginEditingBlock(textField , self.section);
    return YES;
}
- (void)leaveMessageTextFiledShouldBeginEditing:(void(^)(UITextField *curentleaveMessageTextFiled , NSInteger section))curentleaveMessageTextFiled{
    [self setLeaveMessageTextFiledShouldBeginEditingBlock:^(UITextField *textFiled , NSInteger section) {
        curentleaveMessageTextFiled(textFiled ,section);
    }];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
