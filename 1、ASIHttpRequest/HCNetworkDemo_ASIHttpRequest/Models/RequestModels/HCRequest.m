//
//  HCRequest.m
//  HCNetworkDemo_ASIHttpRequest
//
//  Created by wz on 16/4/1.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#import "HCRequest.h"

@implementation HCBaseRequest

- (NSDictionary*)toDictionary {
    NSMutableDictionary* reqDic = [super toDictionary].mutableCopy;
    [reqDic removeObjectsForKeys:@[@"reqMethod", @"reqContentType", @"reqUrl", @"resClassString"]];
    return reqDic;
}

- (NSData*)toJSONData {
    NSDictionary* reqDic = [self toDictionary];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:NSJSONWritingPrettyPrinted error:nil];
    return jsonData;
}

@end

@implementation HCDemoRequest

- (id)init {
    if(self = [super init]) {
        self.reqMethod = HCHttpMethodGet;
        self.reqContentType = HCHttpContentTypeJson;
        self.reqUrl = @"https://www.baidu.com";
        self.resClassString = NSStringFromClass([HCDemoResponse class]);
    }
    return self;
}

@end

@implementation HCFileItem

@end

@implementation HCFileRequest

- (id)init {
    if(self = [super init]) {
        self.reqMethod = HCHttpMethodPost;
        self.reqContentType = HCHttpContentTypeFormData;
        self.reqUrl = @"http://www.baidu.com";
        self.resClassString = NSStringFromClass([HCBaseResponse class]);
    }
    return self;
}

@end
