//
//  BSYApiRequest.h
//  BSYSDK
//
//  Created by Duane on 2020/11/4.
//

#import <BSYSDK/BSYRequest.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSYApiRequestStatus) {
    BSYApiRequestStatusEmpty = 0, // 成功，数据为空
    BSYApiRequestStatusDeny = -403, // 无权限
    BSYApiRequestStatusUnLogin = -505, // 未登录
};

@interface BSYApiRequest : BSYRequest

@end

NS_ASSUME_NONNULL_END
