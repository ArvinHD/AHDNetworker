//
//  HDBaseConst.h
//  HDNetwork
//
//  Created by xiaozuanfeng on 2019/4/1.
//  Copyright © 2019 arvin. All rights reserved.
//

#ifndef HDBaseConst_h
#define HDBaseConst_h

#ifdef __OBJC__

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 发送网络请求回调，处理返回结果
 
 @param success 请求是否成功，YES-成功，NO-失败
 @param status 网络请求响应编码
 @param response 响应数据。如果请求成功，返回响应数据。如果请求失败，返回nil
 @param error 请求错误信息。请求失败是返回错误信息，请求成功返回nil
 */
typedef void (^ BCallback)(BOOL success, NSInteger status, id _Nullable response, NSError * _Nullable error);
typedef void (^ BDownloadCallback)(BOOL success, NSInteger status, NSString * _Nullable location, NSError * _Nullable error);
typedef void (^ BDownloading)(CGFloat rate, CGFloat received, CGFloat total);

#define kClientUrl @"url_for_client"
#define kClientParams @"parameters_for_client"
#define kClientHeaders @"request_headers_for_client"
#define kClinetForms @"form_data_for_client"
#define kFormFileName @"file_name_for_form_data"
#define kFormName @"file_name_for_form_data"
#define kFormMimeType @"mime_type_for_form_data"
#define kFormData @"data_for_form_data"

#endif


#endif /* HDBaseConst_h */
