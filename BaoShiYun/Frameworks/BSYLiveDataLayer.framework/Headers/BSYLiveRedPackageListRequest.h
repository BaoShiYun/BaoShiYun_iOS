//
//  BSYLiveRedPackageListRequest.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveRedPackageListRequest : BSYLiveBaseRequest

- (instancetype)initWithLiveId:(NSString *)liveId AccountId:(NSString *)accountId;

@end

NS_ASSUME_NONNULL_END
