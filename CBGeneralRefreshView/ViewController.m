//
//  ViewController.m
//  CBGeneralRefreshView
//
//  Created by chebao on 16/3/31.
//  Copyright © 2016年 chebao. All rights reserved.
//

#import "ViewController.h"

#import "FirstViewController.h"//没有使用xib的Controller
#import "UIScrollView+HeaderRefresh.h"
//#import "CBRefresh.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
}


- (void)viewDidLayoutSubviews{
    [self.table addRefreshHeader:nil];
//    self.table.headerView;
}


#pragma mark- table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self.table dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    FirstViewController * vc = [[FirstViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark- view controller
-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
