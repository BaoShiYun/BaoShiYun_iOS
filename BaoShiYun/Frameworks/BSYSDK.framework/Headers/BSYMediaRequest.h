//
//  BSYMediaRequest.h
//  BSYSDK
//
//  Created by Duane on 2020/11/4.
//

#import <BSYSDK/BSYRequest.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSYMediaRequestStatus) {
    BSYMediaRequestStatus_InvalidArgument = -1001, //无效参数、解析请求体失败
    BSYMediaRequestStatus_AccessDenied = -1003, // 访问被拒绝
    BSYMediaRequestStatus_InternalError = -1007, //内部信息错误
};

@interface BSYMediaRequest : BSYRequest

@end

NS_ASSUME_NONNULL_END
