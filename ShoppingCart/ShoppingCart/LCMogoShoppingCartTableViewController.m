//
//  LCMogoShoppingCartTableViewController.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/13.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCMogoShoppingCartTableViewController.h"
#import "LCOrderViewController.h"
#import "LCShoppingHeaderView.h"
#import "LCShoppingCartTableViewCell.h"
#import "LCShoppingCartSectionModel.h"
#import "LCShoppingModel.h"
#import "LCFooterView.h"
#import "LCEditButton.h"


#import "LCTestViewController.h"
@interface LCMogoShoppingCartTableViewController ()<LCShoppingHeaderView_delegate , LCShoppingCartTableViewCell_delegate, UITableViewDelegate , UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSMutableArray *myDataArray;
@property (nonatomic , strong) NSMutableArray *selectedIndexPaths;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) LCFooterView *footerView;

@property (nonatomic , assign) double totalPrice;
@property (nonatomic , assign) NSUInteger selectedCount;
@property (nonatomic , assign) NSUInteger allGoodCount;
@end

@implementation LCMogoShoppingCartTableViewController
- (NSMutableArray *)myDataArray{
    if (!_myDataArray) {
        _myDataArray = [NSMutableArray array];
        for (int i = 0; i < self.dataArray.count; i++) {
            LCShoppingCartSectionModel *sectionModel = [[LCShoppingCartSectionModel alloc]init];
            for (int j = 0; j < [self.dataArray[i][@"items"] count]; j++) {
                NSDictionary *dict = [self.dataArray[i][@"items"] objectAtIndex:j];
                self.allGoodCount++;
                LCShoppingModel *rowModel = [[LCShoppingModel alloc]init];
                rowModel.price = [dict[@"price"] doubleValue];
                rowModel.desGood = dict[@"name"];
                rowModel.goodCount = [dict[@"number"] intValue];
                [sectionModel.goodModelArray addObject:rowModel];

            }
            [_myDataArray addObject:sectionModel];
        }
    }
    return _myDataArray;
}
- (NSMutableArray *)selectedIndexPaths{
    if (!_selectedIndexPaths) {
        _selectedIndexPaths = [NSMutableArray array];
        
        for (int i = 0; i < self.dataArray.count; i++) {
            LCShoppingCartSectionModel *sectionModel = [[LCShoppingCartSectionModel alloc]init];
            [_selectedIndexPaths addObject:sectionModel];
        }
    }
    return _selectedIndexPaths;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    [self myDataArray];
    [self makeNavButton];
    [self makeFooterView];
       // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark**nav设置**
- (void)makeNavButton{
    self.navigationItem.title = [NSString stringWithFormat:@"购物车(%lu)",(unsigned long)self.allGoodCount];
    LCEditButton *button = [[LCEditButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [button addTarget:self action:@selector(preessBarEnditButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
}
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击nav编辑按钮
- (void)preessBarEnditButton:(LCEditButton *)button{
    button.selected = !button.selected;
    self.footerView.showNavEdittingView = !self.footerView.showNavEdittingView;
    for (LCShoppingCartSectionModel *sectionModel in self.myDataArray) {
        sectionModel.navEditView = !sectionModel.navEditView;
    }
    
    [self.tableView reloadData];
}

#pragma mark**footerView**
- (void)makeFooterView{
    self.footerView = [LCFooterView loadFooterView];
    self.footerView.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    
    
    [self.view addSubview:self.footerView];
    //全选
    [self.footerView pressAllButtonBlock:^(UIButton *sender) {
        for (int i = 0; i < self.myDataArray.count; i++) {
            LCShoppingCartSectionModel *sectionModel = [self.myDataArray objectAtIndex:i];
            for (LCShoppingModel *model in sectionModel.goodModelArray) {
                if (sender.selected == YES) {
                    if (model.selectedGood == NO) {
                        sectionModel.selectedSection = YES;
                        [self totalPriceAdd:model];
                        model.selectedGood = YES;
                        [[self.selectedIndexPaths[i] goodModelArray] addObject:model];
                    }
                    
                }else{
                    sectionModel.selectedSection = NO;
                    [self totalPrinceSubtraction:model];
                    model.selectedGood = NO;
                    [[self.selectedIndexPaths[i] goodModelArray] removeObject:model];
                }
                
            }
        }
        [self.tableView reloadData];
        NSLog(@"%@",self.selectedIndexPaths);
    }];
    //结算
    [self.footerView pressSettlementButtonBlock:^(UIButton *sender) {
        LCOrderViewController *testVC = [[LCOrderViewController alloc]init];
        testVC.navigationItem.title = @"确认订单";
        [self.navigationController pushViewController:testVC animated:YES];
    }];

}
#pragma mark**如果全部是选中状态,footerView的全选按钮选中**
- (void)setSelectedCount:(NSUInteger)selectedCount{
    _selectedCount = selectedCount;
    if (self.allGoodCount == selectedCount) {
        self.footerView.allButton.selected = YES;
    }
}
#pragma mark**给footerView总价赋值***
- (void)setTotalPrice:(double)totalPrice{
    _totalPrice = totalPrice;
    NSLog(@"%f",totalPrice);
    self.footerView.selectGoodCount = [NSString stringWithFormat:@"%lu",(unsigned long)self.selectedCount];
    self.footerView.totalPriceString = [NSString stringWithFormat:@"%.02f",totalPrice];
    
}
//计算总价 加
- (void)totalPriceAdd:(LCShoppingModel *)model{
    self.selectedCount++;

    self.totalPrice = self.totalPrice + model.price * model.goodCount;
}
//计算总价 减
- (void)totalPrinceSubtraction:(LCShoppingModel *)model{
    self.selectedCount--;

    self.totalPrice = self.totalPrice - model.price * model.goodCount;
}



/**
 *  选中cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    LCTestViewController *testVC = [[LCTestViewController alloc]init];
    testVC.navigationItem.title = @"产品详情";
    [self.navigationController pushViewController:testVC animated:YES];
    
}
/**
 *  取消选中cell
 */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark***cell_Delegate  选中**
- (void)shopingTableViewCell:(LCShoppingCartTableViewCell *)shopingTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LCShoppingModel *model = [self.myDataArray[indexPath.section] goodModelArray][indexPath.row];
    model.selectedGood = YES;
    
    [self totalPriceAdd:model];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [[self.selectedIndexPaths[indexPath.section] goodModelArray] addObject:model];
    if ([self.selectedIndexPaths[indexPath.section] goodModelArray].count== [self.myDataArray[indexPath.section] goodModelArray].count) {
        LCShoppingHeaderView *headerView = (LCShoppingHeaderView *)[self.tableView headerViewForSection:indexPath.section];
        headerView.selectBoxButton.selected = YES;
        LCShoppingCartSectionModel *sectionModel = self.myDataArray[indexPath.section];
        sectionModel.selectedSection = YES;
    }

    NSLog(@"%@",self.selectedIndexPaths);
    
}
#pragma mark***cell_Delegate  取消选中**

- (void)shopingTableViewCell:(LCShoppingCartTableViewCell *)shopingTableViewCell didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.footerView.allButton.selected) {
        self.footerView.allButton.selected = NO;
    }
    LCShoppingModel *model = [self.myDataArray[indexPath.section] goodModelArray][indexPath.row];
    model.selectedGood = NO;
    [self totalPrinceSubtraction:model];

       [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
   
    [[self.selectedIndexPaths[indexPath.section] goodModelArray] removeObject:model];
    
        LCShoppingHeaderView *headerView = (LCShoppingHeaderView *)[self.tableView headerViewForSection:indexPath.section];
        LCShoppingCartSectionModel *sectionModel = self.myDataArray[indexPath.section];
    if (headerView.selectBoxButton.selected == YES) {
        headerView.selectBoxButton.selected = NO;
        sectionModel.selectedSection = NO;

    }
    

       NSLog(@"%@",self.selectedIndexPaths);}
#pragma mark***header_Delegate  选中**

- (void)shoppingHeaderView:(LCShoppingHeaderView *)shoppingHeaderView didSelectRowsAtSection:(NSInteger)section{
    LCShoppingCartSectionModel *sectionModel = self.myDataArray[section];
    sectionModel.selectedSection = YES;
    
    
    for (int i = 0; i < [self.myDataArray[section]  goodModelArray].count; i++) {
        LCShoppingModel *model = [self.myDataArray[section] goodModelArray][i];
        if (model.selectedGood == NO) {
            model.selectedGood = YES;
            [[self.selectedIndexPaths[section] goodModelArray] addObject:model];
            [self totalPriceAdd:model];

        }
    }
    

    NSLog(@"%@",self.selectedIndexPaths);

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark***header_Delegate  取消选中**

- (void)shoppingHeaderView:(LCShoppingHeaderView *)shoppingHeaderView didDeselectRowsAtSection:(NSInteger)section{
    
    if (self.footerView.allButton.selected) {
        self.footerView.allButton.selected = NO;
    }
    LCShoppingCartSectionModel *sectionModel = self.myDataArray[section];

    for (int i = 0; i < [self.myDataArray[section] goodModelArray].count; i++) {
        LCShoppingModel *model = [self.myDataArray[section] goodModelArray][i];
        if (model.selectedGood == YES) {
            model.selectedGood = NO;
            [self totalPrinceSubtraction:model];

            [[self.selectedIndexPaths[section] goodModelArray] removeObject:model];
        }
    }

    NSLog(@"%@",self.selectedIndexPaths);
    sectionModel.selectedSection = NO;

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];

}
#pragma mark***header_Delegate  编辑按钮**

- (void)shoppingHeaderView:(LCShoppingHeaderView *)shoppingHeaderView didSelectEditingButton:(UIButton *)editingButton AtSection:(NSInteger)section{
    LCShoppingCartSectionModel *sectionModel = self.myDataArray[section];
    sectionModel.showEditView = !sectionModel.showEditView;
        for (LCShoppingModel *model in [sectionModel goodModelArray]) {
            model.showEditingView = !model.showEditingView;
            }

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.myDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myDataArray[section] goodModelArray].count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingcell"];
    if (!cell) {
        cell = [LCShoppingCartTableViewCell loadShoppingCell];
        cell.cell_Delegate = self;
    }
    // Configure the cell...
    cell.indextPath = indexPath;
    cell.goodModel = [self.myDataArray[indexPath.section] goodModelArray][indexPath.row];
    return cell;
}
#pragma mark**sectionHeaderView**
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    LCShoppingHeaderView *tittleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[NSString stringWithFormat:@"tittleView%lu",(long)section]];
    if (!tittleView) {
        tittleView = [[LCShoppingHeaderView alloc]initWithReuseIdentifier:[NSString stringWithFormat:@"tittleView%lu",(long)section]];
        tittleView.header_Delegate = self;
    }
    tittleView.section = section;
    tittleView.sectionModel = self.myDataArray[section];
    return tittleView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
#pragma mark**cell侧滑出现的按钮**
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           NSLog(@"删除");
                                                                       }];
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"找相似"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              NSLog(@"找相似");
                                                                          }];
    rowActionSec.backgroundColor = [UIColor greenColor];
    NSArray *arr = @[rowAction,rowActionSec];
    return arr;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
