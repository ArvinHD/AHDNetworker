//
//  BaseClient.m
//  Network
//
//  Created by ArvinHD on 2019/3/29.
//  Copyright © 2019 ArvinHD. All rights reserved.
//

#import "HDBaseClient.h"

@interface HDBaseClient () {
    BOOL _isJson;
}   

@end

@implementation HDBaseClient

@synthesize identifier = _identifier;

- (instancetype)initWithUrl:(NSString *)url
                 parameters:(NSDictionary *)parameters
                    headers:(NSDictionary *)headers
                      forms:(NSDictionary *)forms
                     method:(ESendMethod)method {
    if (self = [super init]) {
        self.url = url;
        self.headers = headers;
        self.parameters = parameters;
        self.forms = forms;
        self.method = method;
    }
    return self;
}

#pragma mark - Setter and getter

- (void)setIdentifier:(NSString * _Nonnull)identifier {
    _identifier = identifier;
}

- (NSString *)identifier {
    return _identifier;
}

- (void)setHeaders:(NSDictionary *)headers {
    if ([headers.allKeys containsObject:@"Content-Type"]) {
        NSString *value = headers[@"Content-Type"];
        if ([value isEqualToString:@"application/json"]) {
            _isJson = YES;
            self.requestSerializer = [AFJSONRequestSerializer serializer];
        } else {
            _isJson = NO;
            self.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
        for (NSString *key in headers) {
            [self.requestSerializer setValue:key forHTTPHeaderField:headers[key]];
        }
    }
}

- (NSURLSessionTask *)send:(BCallback)callback {
    switch (self.method) {
        case kSendGet:
            return [self GET:self.url
                  parameters:self.parameters
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         callback(YES, 200, responseObject, nil);
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         callback(NO, error.code, nil, error);
                     }];
            break;
        case kSendPost:
            return [self POST:self.url
                   parameters:self.parameters
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          callback(YES, 200, responseObject, nil);
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          callback(NO, error.code, nil, error);
                      }];
            break;
        case kSendUpload:
            return [self POST:self.url
                   parameters:self.parameters
    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSDictionary *form in self.forms) {
            if ([form[@"data"] isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:form[kFormData]
                                            name:form[kFormName]
                                        fileName:form[kFormFileName]
                                        mimeType:form[kFormMimeType]];
            } else {
                [formData appendPartWithFileURL:[NSURL URLWithString:form[kFormData]]
                                           name:form[kFormName]
                                       fileName:form[kFormFileName]
                                       mimeType:form[kFormMimeType]
                                          error:nil];
            }
        }
    }
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          callback(YES, 200, responseObject, nil);
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          callback(NO, error.code, nil, error);
                      }];
            break;
        default:
            break;
    }
    return nil;
}

@end
