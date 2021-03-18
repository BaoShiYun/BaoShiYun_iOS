//
//  BSYLiveRtcRoomConfigModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2021/3/4.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveRtcRoomConfigModel : BSYMediaModel
@property (nonatomic, strong)NSString *liveId; //
@property (nonatomic, strong)NSString *interactType; // 连麦配置 close-关闭连麦 video-视频连麦 audio-语音连麦
@property (nonatomic, assign)BOOL audioDisable; //全体静音的开关 false-正常 true-全体闭麦

@end

NS_ASSUME_NONNULL_END
