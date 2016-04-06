//
//  HCResponse.m
//  HCNetworkDemo_ASIHttpRequest
//
//  Created by wz on 16/4/1.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#import "HCResponse.h"

@implementation HCBaseResponse

- (NSError*)error {
    if(self.errCode != 0) {
        return [NSError errorWithDomain:self.msg code:self.errCode userInfo:nil];
    }
    return nil;
}

@end

@implementation HCDemoResponse

@end