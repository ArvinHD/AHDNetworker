//
//  BaseClient.h
//  Network
//
//  Created by ArvinHD on 2019/3/29.
//  Copyright © 2019 ArvinHD. All rights reserved.
//

#import "AFHTTPSessionManager.h"

#import "HDBaseConst.h"


typedef NS_ENUM(NSInteger, ESendMethod) {
    kSendGet,
    kSendPost,
    kSendUpload,
    kSendDownload
};

NS_ASSUME_NONNULL_BEGIN

@interface HDBaseClient : AFHTTPSessionManager

@property (copy, nonatomic) NSString *identifier;

@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSDictionary *parameters;
@property (copy, nonatomic) NSDictionary *headers;
@property (copy, nonatomic) NSDictionary *forms;
@property (assign, nonatomic) ESendMethod method;

- (instancetype)initWithUrl:(NSString *)url
                 parameters:(NSDictionary *)parameters
                    headers:(NSDictionary *)headers
                      forms:(NSDictionary *)forms
                     method:(ESendMethod)method;

- (NSURLSessionTask *)send:(BCallback)callback;

@end

NS_ASSUME_NONNULL_END
