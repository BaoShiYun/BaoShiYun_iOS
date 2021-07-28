//
//  BSYLiveParam.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/12.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
  直播传入参数
 */

@interface BSYLiveParam : NSObject

/**
 *   @brief   租户id（必填）
 */
@property (nonatomic, assign)uint64_t tenantId; ///必填
/**
 *   @brief   用户Uid（必填）
 */
@property (nonatomic, copy)NSString *userId; ///必填
/**
 *   @brief   用户昵称（选填）
 */
@property (nonatomic, copy)NSString *nickName; ///选填
/**
 *   @brief   用户头像（选填）
 */
@property (nonatomic, copy)NSString *avatarUrl; ///选填
/**
 *   @brief   直播间id（必填）
 */
@property (nonatomic, copy)NSString *liveId; ///必填
/**
 *   @brief   直播间enterCode（必填）
 */
@property (nonatomic, copy)NSString *enterCode; ///必填


@end

NS_ASSUME_NONNULL_END
