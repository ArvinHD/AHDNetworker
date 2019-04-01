//
//  Network.h
//  Network
//
//  Created by ArvinHD on 2019/3/29.
//  Copyright © 2019 ArvinHD. All rights reserved.
//

#import "HDNetworkerConst.h"

@interface HDNetworker : NSObject

@property (copy, nonatomic, class, readonly) BShare share;

@property (copy, nonatomic, readonly) BUrl url;
@property (copy, nonatomic, readonly) BParameter parameter;
@property (copy, nonatomic, readonly) BHeader header;
@property (copy, nonatomic, readonly) BFormData formData;
@property (copy, nonatomic, readonly) BFormLocation formLoacation;

@property (copy, nonatomic, readonly) BGet get;
@property (copy, nonatomic, readonly) BPost post;
@property (copy, nonatomic, readonly) BUpload upload;
@property (copy, nonatomic, readonly) BDownload download;

@end
