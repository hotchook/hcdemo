//
//  HCRequest.h
//  HCNetworkDemo_ASIHttpRequest
//
//  Created by wz on 16/4/1.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#ifndef HC_REQUEST
#define HC_REQUEST

typedef enum _HCHttpMethod {
    HCHttpMethodGet = 0,
    HCHttpMethodHead = 1,
    HCHttpMethodPut = 2,
    HCHttpMethodPost = 3,
    HCHttpMethodTrace = 4,
    HCHttpMethodOptions = 5,
    HCHttpMethodDelete = 6,
    HCHttpMethodConnect = 7,
} HCHttpMethod;

typedef enum _HCHttpContentType {
    HCHttpContentTypeFormUrlencode = 0,
    HCHttpContentTypeFormData = 1,
    HCHttpContentTypeJson = 2,
    HCHttpContentTypeXml = 3
} HCHttpContentType;

@interface HCBaseRequest : JSONModel

@property (nonatomic, assign) HCHttpMethod reqMethod;
@property (nonatomic, assign) HCHttpContentType reqContentType;
@property (nonatomic, copy) NSString *reqUrl;
@property (nonatomic, copy) NSString *resClassString;

@end

@interface HCDemoRequest : HCBaseRequest

@property (nonatomic, copy) NSString *param_one;
@property (nonatomic, copy) NSString *param_two;
@property (nonatomic, copy) NSString *param_three;

@end

@interface HCFileItem : NSObject

@property (nonatomic, strong) NSData *fileData;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileContentType;
@property (nonatomic, copy) NSString *fileKey;

@end

@interface HCFileRequest : HCBaseRequest

@property (nonatomic, strong) NSArray<HCFileItem*> *fileItems;

@end


#endif

