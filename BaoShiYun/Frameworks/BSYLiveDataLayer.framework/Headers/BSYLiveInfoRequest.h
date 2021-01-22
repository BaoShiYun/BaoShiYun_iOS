//
//  BSYLiveInfoRequest.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveInfoRequest : BSYLiveBaseRequest
- (instancetype)initLiveId:(NSString *)liveId;
- (instancetype)initLiveId:(NSString *)liveId WithRouteId:(NSString * __nullable)routeId WithUid:(NSString * __nullable)uid;

@end

NS_ASSUME_NONNULL_END
