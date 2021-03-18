//
//  BSYLiveInteractiveConfigModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2021/3/3.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveInteractiveConfigModel : NSObject
@property (nonatomic, assign, readonly) BOOL interactType; //连麦配置 0-关闭连麦 1-视频连麦 2-语音连麦
@property (nonatomic, assign, readonly) BOOL audioDisable; //全体麦克风静音开关  false-正常 true-全体麦克风静音

@end

NS_ASSUME_NONNULL_END
