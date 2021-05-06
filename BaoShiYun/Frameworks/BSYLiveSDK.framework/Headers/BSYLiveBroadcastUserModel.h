//
//  BSYLiveBroadcastUserModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2021/3/3.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 席位信息
 */
@interface BSYLiveBroadcastUserModel : NSObject

/**
 *   @brief  用户ID
 */
@property (nonatomic, strong)NSString *userId;

/**
 *   @brief  昵称
 */
@property (nonatomic, strong)NSString *nickName;

/**
 *   @brief  头像地址
 */
@property (nonatomic, strong)NSString *avatarUrl;

/**
 *   @brief  视频开启或关闭
 *   @discussion true-关闭  false-开启
 */
@property (nonatomic, assign)BOOL videoMute;

/**
 *   @brief  麦克风开启或关闭
 *   @discussion true-关闭  false-开启
 */
@property (nonatomic, assign)BOOL audioMute;

@end

NS_ASSUME_NONNULL_END
