//
//  SecondTestView.m
//  WGCategory
//
//  Created by RayMi on 16/4/5.
//  Copyright © 2016年 WG. All rights reserved.
//

#import "SecondTestView.h"
#import "UITableView+EdgeInsets.h"
@implementation SecondTestView

- (void)awakeFromNib{
    [super awakeFromNib];

    UITableView *table = [[UITableView alloc]initWithFrame:self.bounds];
    [self addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    
    [self wg_setTableView:table
    edgeInsetsAtIndexPath:^UIEdgeInsets(NSIndexPath *indexPath) {
        return UIEdgeInsetsZero;
    }];
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
