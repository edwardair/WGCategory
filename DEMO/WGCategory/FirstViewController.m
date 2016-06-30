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


@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wg_setTableView:_tableview
    edgeInsetsAtIndexPath:^UIEdgeInsets(NSIndexPath *indexPath) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
static NSInteger i = -1;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (i==indexPath.row) {
        return 20;
    }else{
        return 44.f;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestTableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[TestTableViewCell alloc]initWithFrame:CGRectMake(0, 0, tableView.wg_width, 44.f)];
    }
    cell.testLabel.text = [NSString stringWithFormat:@"%@%d",indexPath,arc4random()%10000];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (i==indexPath.row) {
        i = -1;
    }else{
        i = indexPath.row;
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

}
@end
