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


@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wg_setTableView:_tableview
    edgeInsetsAtIndexPath:^UIEdgeInsets(NSIndexPath *indexPath) {
        return UIEdgeInsetsMake(0, 50, 0, 100);
    }];

    
}
//-(void)tableView:(UITableView *)tableView
//   willDisplayCell:(UITableViewCell *)cell
// forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"11111----------------");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",indexPath];
    return cell;
}
@end
