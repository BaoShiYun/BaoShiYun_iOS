//
//  BSYLiveUserInfo.h
//  BSYLiveSDK
//
//  Created by zddMac on 2021/1/26.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 直播用户信息
 */
@interface BSYLiveUserInfo : NSObject

/**
 *   @brief   用户Uid
 */
@property (nonatomic, strong, readonly)NSString *userId;

/**
 *   @brief   用户Buid
 *   @discussion 抱石云ID 用于IM匹配发送消息对应的人的角色使用
 */
@property (nonatomic, strong, readonly)NSString *buid;

/**
 *   @brief   用户昵称
 */
@property (nonatomic, strong, readonly)NSString *nickName;

/**
 *   @brief   用户头像地址
 */
@property (nonatomic, strong, readonly)NSString *avatarUrl;

@end

NS_ASSUME_NONNULL_END
