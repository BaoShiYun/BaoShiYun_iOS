//
//  BSYLiveInteractiveConfigModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2021/3/3.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 互动直播配置信息
 */

@interface BSYLiveInteractiveConfigModel : NSObject

/**
 *   @brief 连麦配置
 *   @discussion  0-关闭连麦 1-视频连麦 2-语音连麦
 */
@property (nonatomic, assign, readonly) BOOL interactType;

/**
 *   @brief 全体麦克风静音开关
 *   @discussion  false-正常 true-全体麦克风静音
 */
@property (nonatomic, assign, readonly) BOOL audioDisable;

@end

NS_ASSUME_NONNULL_END
