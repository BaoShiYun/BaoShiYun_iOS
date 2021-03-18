//
//  BSYLiveRtcQueueStatusRequest.h
//  BSYLiveDataLayer
//
//  Created by DuanGuangming on 2021/3/3.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYLiveDataLayer/BSYLiveDataLayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveRtcQueueStatusRequest : BSYLiveBaseRequest

- (instancetype)initWithUid:(NSString *)uid LiveId:(NSString *)liveId;

@end

NS_ASSUME_NONNULL_END
