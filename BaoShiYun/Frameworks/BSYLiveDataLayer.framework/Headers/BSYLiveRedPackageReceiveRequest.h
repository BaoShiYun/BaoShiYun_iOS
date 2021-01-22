//
//  BSYLiveRedPackageReceiveRequest.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveRedPackageReceiveRequest : BSYLiveBaseRequest

- (instancetype)initWithLiveId:(NSString *)liveId ActivityId:(NSString *)activityId AccountId:(NSString *)accountId Nickname:(NSString *)nickName;

@end

NS_ASSUME_NONNULL_END
