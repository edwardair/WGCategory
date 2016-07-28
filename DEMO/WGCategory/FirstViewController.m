//
//  FirstViewController.m
//  WGCategory
//
//  Created by RayMi on 15/6/2.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "FirstViewController.h"
#import "WGDefines.h"
#import "TestTimerVCViewController.h"
#import "TestTableViewCell.h"
#import "WGTableController.h"


@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) WGTableController *table;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wg_setTableView:_tableview
    edgeInsetsAtIndexPath:^UIEdgeInsets(NSIndexPath *indexPath) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }];

    
    _table = [[WGTableController alloc]initWithTable:_tableview delegate:self];
//    [_table wg_replaceSelector:@selector(tableView:cellForRowAtIndexPath:) withNewSelector:@selector(wg_tableView:cellForRowAtIndexPath:)];
    [_table wg_replaceSelector:@selector(tableView:heightForRowAtIndexPath:) withNewSelector:@selector(wg_tableView:heightForRowAtIndexPath:)];
    [_table wg_replaceSelector:@selector(tableView:didSelectRowAtIndexPath:) withNewSelector:@selector(wg_tableView:didSelectRowAtIndexPath:)];
//    [_table wg_selector:@selector(tableView:cellForRowAtIndexPath:) forProtocol:@protocol(UITableViewDataSource)];


//    [_table addCells:<#(NSArray<UITableViewCell *> *)#> atSection:<#(NSInteger)#> animation:<#(UITableViewRowAnimation)#>]
    
    
    
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
    [self.table addCells:tmp atSection:0];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
//}
//static NSInteger i = -1;
- (CGFloat)wg_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [UITableViewCell new];
//    cell.textLabel.text=  [NSString stringWithFormat:@"firstViewController:%@",indexPath    ];
//    return cell;
//}
- (UITableViewCell *)wg_tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text=  [NSString stringWithFormat:@"wg_firstViewController:%@",indexPath    ];
    return cell;
}

- (void)wg_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%s",__FUNCTION__);
//    if (i==indexPath.row) {
//        i = -1;
//    }else{
//        i = indexPath.row;
//    }
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

}
@end
