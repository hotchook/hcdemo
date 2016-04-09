//
//  UIViewController+HCHud.m
//  HCHudDemo-MBProgressHUD
//
//  Created by wz on 16/4/9.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#import "UIViewController+HCHud.h"
#import "MBProgressHUD.h"

@implementation UIViewController (HCHud)

- (void)showWait:(NSString*)wait {
    if([self isKindOfClass:[UITableViewController class]]) {
        UITableViewController* tbCtrl = (UITableViewController*)self;
        tbCtrl.tableView.scrollEnabled = NO;
    }
    else if([self isKindOfClass:[UICollectionViewController class]]) {
        UICollectionViewController* ctCtrl = (UICollectionViewController*)self;
        ctCtrl.collectionView.scrollEnabled = NO;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = YES;
    hud.color = [UIColor colorWithWhite:0 alpha:.75f];
    hud.activityIndicatorColor = [UIColor whiteColor];
    hud.labelText = wait;
    [self.view bringSubviewToFront:hud];
}

- (void)showMessage:(NSString*)msg {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = YES;
    hud.color = [UIColor colorWithWhite:0 alpha:.75f];
    hud.activityIndicatorColor = [UIColor whiteColor];
    hud.labelText = msg;
    [hud hide:YES afterDelay:1.2f];
}

- (void)hideHud {
    [[MBProgressHUD HUDForView:self.view] hide:YES];
    if([self isKindOfClass:[UITableViewController class]]) {
        UITableViewController* tbCtrl = (UITableViewController*)self;
        tbCtrl.tableView.scrollEnabled = YES;
    }
    else if([self isKindOfClass:[UICollectionViewController class]]) {
        UICollectionViewController* ctCtrl = (UICollectionViewController*)self;
        ctCtrl.collectionView.scrollEnabled = YES;
    }
}

@end
