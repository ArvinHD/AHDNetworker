//
//  Network.m
//  Network
//
//  Created by ArvinHD on 2019/3/29.
//  Copyright © 2019 ArvinHD. All rights reserved.
//

#import "HDNetworker.h"

#import <HDBaseClient.h>

@interface HDNetworker () {
    
}

@property (strong, nonatomic) NSMutableDictionary *mClients;
@property (strong, nonatomic) HDBaseClient *client;

@end

@implementation HDNetworker

#pragma mark - Initialize method

+ (instancetype)shareInstance {
    static HDNetworker *network;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[HDNetworker alloc] init];
    });
    return network;
}

+ (HDNetworker * _Nonnull (^)(HDBaseClient * _Nullable))share {
    HDNetworker *networker = [HDNetworker shareInstance];
    __weak typeof(networker) weak = networker;
    return ^ (HDBaseClient *client) {
        __strong typeof(weak) strong = weak;
        if (!client) {
            client = [[HDBaseClient alloc] init];
            strong.mClients[client.identifier] = [strong getConfigs:client.identifier];
        }
        strong.client = client;
        return networker;
    };
}

#pragma mark - Getter

- (HDNetworker * _Nonnull (^)(NSString * _Nonnull))url {
    __weak typeof(self) weak = self;
    return ^ (NSString *url) {
        __strong typeof(weak) strong = weak;
        NSMutableDictionary *mParams = strong.mClients[strong.client.identifier];
        mParams[kClientUrl] = url;
        return strong;
    };
}

- (HDNetworker * _Nullable (^)(NSString * _Nullable, id _Nullable))parameter {
    __weak typeof(self) weak = self;
    return ^ (NSString *key, id value) {
        __strong typeof(weak) strong = weak;
        NSMutableDictionary *mParams = strong.mClients[strong.client.identifier];
        NSMutableDictionary *mParameters = mParams[kClientParams];
        if (!mParameters) {
            mParameters = [NSMutableDictionary dictionary];
        }
        mParameters[key] = value;
        return strong;
    };
}

- (HDNetworker * _Nullable (^)(NSString * _Nullable, NSString * _Nullable))header {
    __weak typeof(self) weak = self;
    return ^ (NSString *key, NSString *value) {
        __strong typeof(weak) strong = weak;
        NSMutableDictionary *mParams = strong.mClients[strong.client.identifier];
        NSMutableDictionary *mHeaders = mParams[kClientHeaders];
        if (!mHeaders) {
            mHeaders = [NSMutableDictionary dictionary];
        }
        mHeaders[key] = value;
        return strong;
    };
}

- (HDNetworker * _Nullable (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull, NSData * _Nonnull))formData {
    __weak typeof(self) weak = self;
    return ^ (NSString * fileName, NSString * name, NSString * mimeType, NSData * data) {
        __strong typeof(weak) strong = weak;
        NSMutableDictionary *mParams = strong.mClients[strong.client.identifier];
        NSMutableArray *mDatas = mParams[kClinetForms];
        if (!mDatas) {
            mDatas = [NSMutableArray array];
        }
        [mDatas addObject:@{
                            kFormFileName : fileName,
                            kFormName : name,
                            kFormMimeType : mimeType,
                            kFormData : data
                            }];
        return strong;
    };
}

- (HDNetworker * _Nullable (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))formLocation {
    __weak typeof(self) weak = self;
    return ^ (NSString * fileName, NSString * name, NSString * mimeType, NSString * location) {
        __strong typeof(weak) strong = weak;
        NSMutableDictionary *mParams = strong.mClients[strong.client.identifier];
        NSMutableArray *mDatas = mParams[kClinetForms];
        if (!mDatas) {
            mDatas = [NSMutableArray array];
        }
        [mDatas addObject:@{
                            kFormFileName : fileName,
                            kFormName : name,
                            kFormMimeType : mimeType,
                            kFormData : location
                            }];
        return strong;
    };
}

- (NSURLSessionTask * _Nullable (^)(BCallback _Nonnull))get {
    __weak typeof(self) weak = self;
    return ^ (BCallback callback) {
        __strong typeof(weak) strong = weak;
        [strong configClient];
        strong.client.method = kSendGet;
        return [strong.client send:callback];
    };
}

- (NSURLSessionTask * _Nullable (^)(BCallback _Nonnull))post {
    __weak typeof(self) weak = self;
    return ^ (BCallback callback) {
        __strong typeof(weak) strong = weak;
        [strong configClient];
        strong.client.method = kSendPost;
        return [strong.client send:callback];
    };
}

- (NSURLSessionTask * _Nullable (^)(BCallback _Nonnull))upload {
    __weak typeof(self) weak = self;
    return ^ (BCallback callback) {
        __strong typeof(weak) strong = weak;
        [strong configClient];
        strong.client.method = kSendUpload;
        return [strong.client send:callback];
    };
}

- (BDownload)download {
    return ^ (BDownloading downloading, BDownloadCallback callback) {
        return [[NSURLSessionTask alloc] init];
    };
}

#pragma mark - Private immplement method

- (NSMutableDictionary *)getConfigs:(NSString *)clientId {
    if ([self.mClients.allKeys containsObject:clientId]) {
        return self.mClients[clientId];
    }
    NSMutableDictionary *mConfig = [NSMutableDictionary dictionary];
    return mConfig;
}

- (void)configClient {
    NSDictionary *configs = self.mClients[self.client.identifier];
    self.client.url = configs[kClientUrl];
    self.client.parameters = configs[kClientParams];
    self.client.headers = configs[kClientHeaders];
    self.client.forms = configs[kClinetForms];
}

@end
