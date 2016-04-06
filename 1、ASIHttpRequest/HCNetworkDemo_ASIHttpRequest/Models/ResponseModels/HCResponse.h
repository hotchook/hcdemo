//
//  HCResponse.h
//  HCNetworkDemo_ASIHttpRequest
//
//  Created by wz on 16/4/1.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#ifndef HC_RESPONSE
#define HC_RESPONSE

@interface HCBaseResponse : JSONModel

- (NSError*)error;

@property (nonatomic, assign) NSInteger errCode; //响应状态码，0表示请求成功
@property (nonatomic, copy) NSString *msg; //显示信息
@property (nonatomic, copy) NSString<Optional> *data;

@end

@interface HCDemoResponse : HCBaseResponse

@property (nonatomic, copy) NSString *res_one;
@property (nonatomic, copy) NSString *res_two;
@property (nonatomic, copy) NSString *res_three;

@end

#endif