//
//  TableViewController.m
//  HCHudDemo_MBProgressHUD
//
//  Created by wz on 16/4/9.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[UIView new]];
    
    [self showWait:@"wait..."];
//    [self performSelector:@selector(hideHud) withObject:nil afterDelay:2];
    //    [self showMessage:@"msg..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
