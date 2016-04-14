//
//  LCShoppingCartTableViewController.m
//  ShoppingCart
//
//  Created by MoGo on 16/4/12.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCShoppingCartTableViewController.h"
#import "LCShopingTableViewCell.h"
#import "LCShoppingHeaderView.h"
#import "LCTestViewController.h"
@interface LCShoppingCartTableViewController ()<LCShopingTableViewCell_delegate , LCShoppingHeaderView_delegate>
@property (nonatomic , strong) NSMutableArray *myDataArray;
@property (nonatomic , strong) NSMutableArray *selectedIndexPaths;
@property (nonatomic , strong) NSArray *allselectedIndesPaht;
@end

@implementation LCShoppingCartTableViewController
- (NSMutableArray *)myDataArray{
    if (!_myDataArray) {
        _myDataArray = [NSMutableArray arrayWithArray:self.dataArray];
    }
    return _myDataArray;
}
- (NSMutableArray *)selectedIndexPaths{
    if (!_selectedIndexPaths) {
        _selectedIndexPaths = [NSMutableArray array];

        for (int i = 0; i < self.dataArray.count; i++) {
            [_selectedIndexPaths addObject:[NSMutableArray array]];
        }
    }
    return _selectedIndexPaths;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableView.allowsMultipleSelection=YES;
    
       
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
/**
 *  选中
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    LCTestViewController *testVC = [[LCTestViewController alloc]init];
    [self.navigationController pushViewController:testVC animated:YES];
  
}
/**
 *  取消选中
 */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}
- (void)shopingTableViewCell:(LCShopingTableViewCell *)shopingTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.selectedIndexPaths[indexPath.section] addObject:indexPath];
    if ([self.selectedIndexPaths[indexPath.section] count] == [self.myDataArray[indexPath.section][@"items"] count]) {
        LCShoppingHeaderView *headerView = (LCShoppingHeaderView *)[self.tableView headerViewForSection:indexPath.section];
        
        headerView.selectBoxButton.selected = YES;
        
    }
    NSLog(@"%s\n%@",__func__,self.selectedIndexPaths);

}

- (void)shopingTableViewCell:(LCShopingTableViewCell *)shopingTableViewCell didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    LCShoppingHeaderView *headerView = (LCShoppingHeaderView *)[self.tableView headerViewForSection:indexPath.section];
    if (headerView.selectBoxButton.selected) {
        headerView.selectBoxButton.selected = NO;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.selectedIndexPaths[indexPath.section] removeObject:indexPath];
    NSLog(@"%s\n%@",__func__,self.selectedIndexPaths);
}

- (void)shoppingHeaderView:(LCShoppingHeaderView *)shoppingHeaderView didSelectRowsAtSection:(NSInteger)section{
    for (int i = 0; i < [self.myDataArray[section][@"items"] count]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.selected == NO) {
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.selectedIndexPaths[indexPath.section] addObject:indexPath];
        }
    }
    self.allselectedIndesPaht = [self.tableView indexPathsForSelectedRows];
    NSLog(@"%@",[self.tableView indexPathsForSelectedRows]);

    NSLog(@"%s\n%@",__func__,self.selectedIndexPaths);

}
- (void)shoppingHeaderView:(LCShoppingHeaderView *)shoppingHeaderView didDeselectRowsAtSection:(NSInteger)section{
    for (int i = 0; i < [self.myDataArray[section][@"items"] count]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
         [self.selectedIndexPaths[indexPath.section] removeObject:indexPath];
    }
    NSLog(@"%s\n%@",__func__,self.selectedIndexPaths);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.myDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myDataArray[section][@"items"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCShopingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [LCShopingTableViewCell loadShoppingCell];
        cell.cell_Delegate = self;
    }
    // Configure the cell...
    cell.indextPath = indexPath;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    LCShoppingHeaderView *tittleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[NSString stringWithFormat:@"tittleView%lu",section]];
    if (!tittleView) {
        tittleView = [[LCShoppingHeaderView alloc]initWithReuseIdentifier:[NSString stringWithFormat:@"tittleView%lu",section]];
        tittleView.header_Delegate = self;
        NSLog(@"%s",__func__);
    }
    tittleView.section = section;
    return tittleView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
//    
//}
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}

-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           NSLog(@"删除");
                                                                       }];
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"标记"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              NSLog(@"标记");
                                                                          }];
    rowActionSec.backgroundColor = [UIColor greenColor];
    NSArray *arr = @[rowAction,rowActionSec];
    for (NSIndexPath *path in self.allselectedIndesPaht) {
        [self.tableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    NSLog(@"%@",[self.tableView indexPathsForSelectedRows]);
    return arr;
}

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
