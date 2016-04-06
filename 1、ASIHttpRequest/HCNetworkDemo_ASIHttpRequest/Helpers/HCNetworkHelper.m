//
//  HCNetworkHelper.m
//  HCNetworkDemo_ASIHttpRequest
//
//  Created by wz on 16/4/1.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#import "HCNetworkHelper.h"
#import "ASIFormDataRequest.h"

@implementation HCNetworkHelper

+ (void)hcSendAsyncHttpRequest:(HCBaseRequest*)baseRequest
                  SuccessBlock:(HCHttpRequestSuccessBlock)successBlock
                     FailBlock:(HCHttpRequestFailBlock)failBlock {
    [HCNetworkHelper hcSendAsyncHttpRequest:baseRequest SuccessBlock:successBlock FailBlock:failBlock ProgressBlock:nil];
}

+ (void)hcSendAsyncHttpRequest:(HCBaseRequest*)baseRequest
                  SuccessBlock:(HCHttpRequestSuccessBlock)successBlock
                     FailBlock:(HCHttpRequestFailBlock)failBlock
                 ProgressBlock:(ASIProgressBlock)progressBlock {

    [HCNetworkHelper hcSendHttpRequest:baseRequest SuccessBlock:successBlock FailBlock:failBlock ProgressBlock:progressBlock IsAsync:YES];
}

+ (id)hcSendSyncHttpRequest:(HCBaseRequest*)baseRequest {
    return [HCNetworkHelper hcSendHttpRequest:baseRequest SuccessBlock:nil FailBlock:nil ProgressBlock:nil IsAsync:NO];
}

+ (id)handleResponseString:(NSString*)responseString
               BaseRequest:(HCBaseRequest*)baseRequest
              SuccessBlock:(HCHttpRequestSuccessBlock)successBlock
                 FailBlock:(HCHttpRequestFailBlock)failBlock {
    NSDictionary* resDic = nil;
    
#ifdef HTTP_JSON_RESPONSE
    NSData* responseData = [[NSData alloc] initWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding]];
    resDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
#else
    resDic = [NSDictionary dictionaryWithXMLData:responseString];
#endif
    
    Class resClass = NSClassFromString(baseRequest.resClassString);
    id res = [[resClass alloc] initWithDictionary:resDic error:nil];
    HCBaseResponse* baseResponse = (HCBaseResponse*)res;
    
    if(baseResponse.errCode == 0) {
        if(successBlock) {
            successBlock(responseString, res);
        }
    }
    else {
        if(failBlock) {
            failBlock(baseResponse.error);
        }
    }
    
    return res;
}


+ (id)hcSendHttpRequest:(HCBaseRequest*)baseRequest
           SuccessBlock:(HCHttpRequestSuccessBlock)successBlock
              FailBlock:(HCHttpRequestFailBlock)failBlock
          ProgressBlock:(ASIProgressBlock)progressBlock
                IsAsync:(BOOL)isAsync {
    ASIHTTPRequest* httpRequest = nil;
    NSURL* reqUrl = [NSURL URLWithString:baseRequest.reqUrl];
    
    switch (baseRequest.reqContentType) {
        case HCHttpContentTypeFormUrlencode:
        {
            NSDictionary* reqDic = [baseRequest toDictionary];
            ASIFormDataRequest* formReq = [ASIFormDataRequest requestWithURL:reqUrl];
            httpRequest = formReq;
            [formReq setPostFormat:ASIURLEncodedPostFormat];
            for(id key in [reqDic allKeys]) {
                id value = reqDic[key];
                [formReq addPostValue:value forKey:key];
            }
        }
            break;
        case HCHttpContentTypeFormData:
        {
            NSDictionary* reqDic = [baseRequest toDictionary];
            ASIFormDataRequest* formReq = [ASIFormDataRequest requestWithURL:reqUrl];
            httpRequest = formReq;
            [formReq setPostFormat:ASIURLEncodedPostFormat];
            for(id key in [reqDic allKeys]) {
                id value = reqDic[key];
                if([value isKindOfClass:[NSArray class]]) {
                    NSArray* fileItems = (NSArray*)value;
                    for(HCFileItem* fileItem in fileItems) {
                        [formReq addData:fileItem.fileData withFileName:fileItem.fileName andContentType:fileItem.fileContentType forKey:fileItem.fileKey];
                    }
                }
                else {
                    [formReq addPostValue:value forKey:key];
                }
            }
            [httpRequest setTimeOutSeconds:TIME_OUT_FOR_UPLOAD_FILE];
        }
            break;
        case HCHttpContentTypeJson:
        {
            httpRequest = [ASIHTTPRequest requestWithURL:reqUrl];
            NSMutableData* reqData = [baseRequest toJSONData].mutableCopy;
            [httpRequest addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [httpRequest addRequestHeader:@"Accept" value:@"application/json"];
            [httpRequest setPostBody:reqData];
        }
            break;
        case HCHttpContentTypeXml:
        {
            NSDictionary* reqDic = [baseRequest toDictionary];
            httpRequest = [ASIHTTPRequest requestWithURL:reqUrl];
            NSMutableData* reqData = [NSPropertyListSerialization dataWithPropertyList:reqDic format:NSPropertyListXMLFormat_v1_0 options:0 error:nil].mutableCopy;
            [httpRequest addRequestHeader:@"Content-Type" value:@"application/x-plist; encoding=utf-8"];
            [httpRequest setPostBody:reqData];
        }
            break;
        default:
            break;
    }
    
    switch (baseRequest.reqMethod) {
        case HCHttpMethodGet:
        {
            [httpRequest setRequestMethod:@"GET"];
        }
            break;
        case HCHttpMethodHead:
        {
            [httpRequest setRequestMethod:@"HEAD"];
        }
            break;
        case HCHttpMethodPut:
        {
            [httpRequest setRequestMethod:@"PUT"];
        }
            break;
        case HCHttpMethodPost:
        {
            [httpRequest setRequestMethod:@"POST"];
        }
            break;
        case HCHttpMethodTrace:
        {
            [httpRequest setRequestMethod:@"TRACE"];
        }
            break;
        case HCHttpMethodOptions:
        {
            [httpRequest setRequestMethod:@"OPTIONS"];
        }
            break;
        case HCHttpMethodDelete:
        {
            [httpRequest setRequestMethod:@"DELETE"];
        }
            break;
        case HCHttpMethodConnect:
        {
            [httpRequest setRequestMethod:@"CONNECT"];
        }
            break;
        default:
            break;
    }
   
    [httpRequest setResponseEncoding:NSUTF8StringEncoding];
    
    if(isAsync) {
        __block ASIHTTPRequest* blockRequest = httpRequest;
        
        [httpRequest setBytesSentBlock:progressBlock];
        [httpRequest setCompletionBlock:^ {
            [HCNetworkHelper handleResponseString:blockRequest.responseString BaseRequest:baseRequest SuccessBlock:successBlock FailBlock:failBlock];
        }];
        
        [httpRequest setFailedBlock:^ {
            NSError* error = blockRequest.error;
            if(failBlock) {
                failBlock(error);
            }
        }];
        
        [httpRequest startAsynchronous];
        
        return nil;
    }
    
    [httpRequest startSynchronous];
    
    if(httpRequest.error) {
        Class resClass = NSClassFromString(baseRequest.resClassString);
        id res = [[resClass alloc] init];
        
        HCBaseResponse* baseResponse = (HCBaseResponse*)res;
        baseResponse.errCode = httpRequest.error.code;
        baseResponse.msg = httpRequest.error.domain;
        
        return res;
    }
    
    id res = [HCNetworkHelper handleResponseString:httpRequest.responseString BaseRequest:baseRequest SuccessBlock:successBlock FailBlock:failBlock];
    if(!res) {
        Class resClass = NSClassFromString(baseRequest.resClassString);
        res = [[resClass alloc] init];
        
        HCBaseResponse* baseResponse = (HCBaseResponse*)res;
        baseResponse.errCode = 0;
        baseResponse.msg = @"";
        baseResponse.data = httpRequest.responseString;
    }
    
    return res;
}

@end
