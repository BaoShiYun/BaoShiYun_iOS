//
//  BSYLiveRtcSeatUpdateRequest.h
//  BSYLiveDataLayer
//
//  Created by DuanGuangming on 2021/3/2.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYLiveDataLayer/BSYLiveDataLayer.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSYLiveRtcSeatStatus) {
    BSYLiveRtcSeatStatusNormal = 1,  ///< 正常
    BSYLiveRtcSeatStatusHangUp = 2,  ///< 挂断
};

@interface BSYLiveRtcSeatUpdateRequest : BSYLiveBaseRequest

- (instancetype)initWithSeatId:(NSString *)seatId status:(BSYLiveRtcSeatStatus)status;

@end

NS_ASSUME_NONNULL_END
