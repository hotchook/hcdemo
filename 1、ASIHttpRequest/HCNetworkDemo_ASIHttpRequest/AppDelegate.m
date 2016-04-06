//
//  AppDelegate.m
//  HCNetworkDemo_ASIHttpRequest
//
//  Created by wz on 16/3/31.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    HCDemoRequest* demoReq = [[HCDemoRequest alloc] init];
    demoReq.param_one = @"param_one";
    demoReq.param_two = @"param_two";
    demoReq.param_three = @"param_three";
    
    [HCNetworkHelper hcSendAsyncHttpRequest:demoReq SuccessBlock:^ (NSString* resStr, HCBaseResponse* baseRes) {
        NSLog(@"network success : %@ %@", resStr, baseRes);
    } FailBlock:^ (NSError* error) {
        NSLog(@"network fail : %@", error);
    }];
    
    HCDemoResponse* demoRes = (HCDemoResponse*)[HCNetworkHelper hcSendSyncHttpRequest:demoReq];
    NSLog(@"demo res : %@", demoRes);
    
    HCFileRequest* fileReq = [[HCFileRequest alloc] init];
    HCFileItem* fileItem = [[HCFileItem alloc] init];
    fileItem.fileData = [[NSData alloc] initWithBase64EncodedString:@"filedata" options:0];
    fileItem.fileContentType = @"filecontenttype";
    fileItem.fileKey = @"filekey";
    fileItem.fileName = @"filename";
    fileReq.fileItems = @[fileItem];
    
    [HCNetworkHelper hcSendAsyncHttpRequest:fileReq SuccessBlock:^ (NSString* resStr, HCBaseResponse* baseRes) {
        NSLog(@"network success : %@ %@", resStr, baseRes);
    } FailBlock:^ (NSError* error) {
        NSLog(@"network fail : %@", error);
    } ProgressBlock:^ (unsigned long long size, unsigned long long total) {
        NSLog(@"network progress : %ld %ld", size, total);
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
