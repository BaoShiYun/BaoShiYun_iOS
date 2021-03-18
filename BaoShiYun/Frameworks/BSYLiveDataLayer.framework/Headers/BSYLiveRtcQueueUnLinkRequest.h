//
//  BSYLiveRtcQueueUnLinkRequest.h
//  BSYLiveDataLayer
//
//  Created by DuanGuangming on 2021/3/2.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYLiveDataLayer/BSYLiveDataLayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveRtcQueueUnLinkRequest : BSYLiveBaseRequest

- (instancetype)initWithUid:(NSString *)uid LiveId:(NSString *)liveId NickName:(NSString *)nickname;

@end

NS_ASSUME_NONNULL_END
