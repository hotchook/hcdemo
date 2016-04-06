//
//  HCNetworkHelper.h
//  HCNetworkDemo_ASIHttpRequest
//
//  Created by wz on 16/4/1.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#ifndef HC_NETWORK_HELPER
#define HC_NETWORK_HELPER

#import <Foundation/Foundation.h>
#import "ASIHttpRequest.h"

typedef void (^ HCHttpRequestSuccessBlock) (NSString *resStr, HCBaseResponse *baseRes);
typedef void (^ HCHttpRequestFailBlock) (NSError *error);

@interface HCNetworkHelper : NSObject

+ (void)hcSendAsyncHttpRequest:(HCBaseRequest*)baseRequest
                  SuccessBlock:(HCHttpRequestSuccessBlock)successBlock
                     FailBlock:(HCHttpRequestFailBlock)failBlock;

+ (void)hcSendAsyncHttpRequest:(HCBaseRequest*)baseRequest
                  SuccessBlock:(HCHttpRequestSuccessBlock)successBlock
                     FailBlock:(HCHttpRequestFailBlock)failBlock
                 ProgressBlock:(ASIProgressBlock)progressBlock;

+ (id)hcSendSyncHttpRequest:(HCBaseRequest*)baseRequest;

@end

#endif
