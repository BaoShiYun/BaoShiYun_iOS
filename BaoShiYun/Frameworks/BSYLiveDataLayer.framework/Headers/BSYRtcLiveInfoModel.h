//
//  BSYRtcLiveInfoModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/12/9.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYRtcLiveInfoModel : BSYMediaModel

@property (nonatomic, strong)NSString *channelName;
@property (nonatomic, strong)NSString *channelToken;
@property (nonatomic, strong)NSString *boardRoomId;
@property (nonatomic, strong)NSString *boardToken;

@end

NS_ASSUME_NONNULL_END
