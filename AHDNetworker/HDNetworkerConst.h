//
//  HDNetworkerConst.h
//  HDNetwork
//
//  Created by xiaozuanfeng on 2019/4/1.
//  Copyright © 2019 arvin. All rights reserved.
//

#ifndef HDNetworkerConst_h
#define HDNetworkerConst_h


#ifdef __OBJC__

#import "HDBaseConst.h"

@class HDNetworker;
@class HDBaseClient;

/**
 获取Networker实例，单例。
 传入HDBaseClient可获取该连接器的请求配置
 
 @param client 连接器实例，AFHTTPSessionManager子类实例。
 @return 连接器
 */
typedef HDNetworker * _Nonnull(^ _Nullable BShare)(HDBaseClient * _Nullable client);
typedef HDNetworker * _Nonnull(^ _Nonnull BUrl)(NSString * _Nonnull url);
typedef HDNetworker * _Nullable(^ _Nullable BParameter)(NSString * _Nullable key, id _Nullable value);
typedef HDNetworker * _Nullable(^ _Nullable BHeader)(NSString * _Nullable key, NSString * _Nullable value);
typedef HDNetworker * _Nullable(^ _Nullable BFormData)(NSString * _Nonnull fileName, NSString * _Nonnull name, NSString * _Nonnull mimeType, NSData* _Nonnull data);
typedef HDNetworker * _Nullable(^ _Nullable BFormLocation)(NSString * _Nonnull fileName, NSString * _Nonnull name, NSString * _Nonnull mimeType, NSString * _Nonnull location);

typedef  NSURLSessionTask * _Nullable(^ _Nullable BPost)(BCallback _Nonnull callback);
typedef NSURLSessionTask * _Nullable(^ _Nullable BGet)(BCallback _Nonnull callback);
typedef NSURLSessionTask * _Nullable(^ _Nullable BUpload)(BCallback _Nonnull callback);
typedef NSURLSessionTask * _Nullable(^ _Nullable BDownload)(BDownloading _Nullable downloading, BDownloadCallback _Nonnull callback);


#endif

#endif /* HDNetworkerConst_h */
