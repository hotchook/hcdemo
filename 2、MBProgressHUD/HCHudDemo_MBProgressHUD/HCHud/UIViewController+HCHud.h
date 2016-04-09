//
//  UIViewController+HCHud.h
//  HCHudDemo-MBProgressHUD
//
//  Created by wz on 16/4/9.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HCHud)

- (void)showWait:(NSString*)wait;
- (void)showMessage:(NSString*)msg;
- (void)hideHud;

@end
