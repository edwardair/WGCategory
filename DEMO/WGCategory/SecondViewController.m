//
//  SecondViewController.m
//  WGCategory
//
//  Created by RayMi on 15/6/2.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "SecondViewController.h"
#import "WGDefines.h"
#import "TestTableViewCell.h"



#pragma mark ---------------------------------------------------------
@interface SecondViewController ()

@end

@implementation SecondViewController
//@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self disableAutoAdjustScrollViewInsets];
//    self.tableView.delegate = self;
}
- (IBAction)reload:(id)sender {
    [self reloadAllCells];
}

- (IBAction)delete:(id)sender {
    int count = 10;
    NSMutableArray *indexes = @[].mutableCopy;
    NSMutableArray *theSection = [self sectionAtIndex:0];
    for (NSInteger i = theSection.count-1; i>=0; i--) {
        [indexes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        count--;
        if (count<=0) {
            break;
        }
    }
    [self deleteCellsAtIndexes:indexes];
}

- (IBAction)newCell{
    NSArray *datas = @[
                       @"1法法师法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎哇嘎我馆娃宫哇嘎挖1",
                       @"2法法师嘎嘎哇嘎我馆娃宫嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎哇嘎法师嘎2",
                       @"3法法师嘎嘎哇嘎我馆娃嘎哇嘎我馆娃宫哇嘎法师嘎宫哇嘎法师嘎",
                       @"4法法师法师嘎嘎哇嘎娃宫哇嘎法师嘎嘎哇嘎我馆娃宫我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎哇嘎我馆娃宫哇嘎挖",
                       @"5法法师法师嘎嘎哇嘎我馆娃宫哇嘎法娃宫哇嘎法师嘎嘎哇嘎我馆娃宫师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎哇嘎我馆娃宫哇嘎挖",
                       @"6法法师嘎嘎哇嘎我馆娃宫哇娃宫哇嘎法师嘎嘎哇嘎我馆娃宫娃宫哇嘎法师嘎嘎哇嘎我馆娃宫娃宫哇嘎法师嘎嘎哇嘎我馆娃宫嘎法师嘎",
                       @"7法法师嘎嘎哇嘎我馆娃娃宫哇嘎法师嘎嘎哇嘎我馆娃宫娃宫哇嘎法师嘎嘎哇嘎我馆娃宫宫哇嘎法师嘎",
                       @"8法法师法师嘎嘎哇娃宫哇嘎法师嘎嘎哇嘎我馆娃宫嘎我馆娃宫哇嘎法师嘎嘎娃宫哇嘎法师嘎嘎哇嘎我馆娃宫娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎哇嘎我馆娃宫哇嘎挖",
                       @"9法法师法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎哇嘎我馆娃宫哇嘎挖",
                       @"10法法师法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎法师嘎嘎哇嘎我馆娃宫哇嘎哇嘎我馆娃宫哇嘎挖",
                       ];
//    datas = [datas arrayByAddingObjectsFromArray:datas];
    NSMutableArray *tmp = @[].mutableCopy;
    for (NSString *str in datas) {
        TestTableViewCell *cell = [[TestTableViewCell alloc]initWithFrame:CGRectMake(0, 0, 414, 44.)];
        [cell loadModel:str
           doReload:^(TestTableViewCell* cell_, id model_) {
               cell_.testLabel.text = model_;
           }];
        [tmp addObject:cell];
    }
    [self addCells:tmp atSection:0];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self deleteCellsAtIndexes:@[indexPath]];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"测试数据" message:@"msg" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *theSection = [self sectionAtIndex:indexPath.section];
        TestTableViewCell *cell = theSection[indexPath.row];
        [cell updateModel:[[alert textFields].firstObject text]];
        [cell setNeedUpdateHeight];
//        
//        [self.tableView beginUpdates];
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView endUpdates];
////        [self.tableView beginUpdates];
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
////        [self.tableView endUpdates];
//        
//
        [self reloadCells:@[cell]];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *theSection = self.cells[indexPath.section];
        TestTableViewCell *cell = theSection[indexPath.row];
        [UIPasteboard generalPasteboard].string = cell.model;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"insert" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *datas = @[
                           @"1insert",
                           @"2insert",
                           @"3insert",
                           ];
        NSMutableArray *tmp = @[].mutableCopy;
        NSMutableArray *indexes = @[].mutableCopy;
        NSInteger i = indexPath.row;
        for (NSString *str in datas) {
            TestTableViewCell *cell = [[TestTableViewCell alloc]initWithFrame:CGRectMake(0, 0, 414, 44.)];
            [cell loadModel:str
                   doReload:^(TestTableViewCell* cell_, id model_) {
                       cell_.testLabel.text = model_;
                   }];
            [tmp addObject:cell];
            [indexes addObject:[NSIndexPath indexPathForRow:i++ inSection:0]];
        }
        [self insertCells:tmp atRow:indexPath.row inSection:0];
    }]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"test";
    }];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
@end


