//
//  BSYLiveParam.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/12.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveParam : NSObject

/**
 *   @brief   租户id
 */
@property (nonatomic, assign)uint64_t tenantId; //必填
/**
 *   @brief   用户Uid
 */
@property (nonatomic, copy)NSString *userId; //必填
/**
 *   @brief   用户昵称
 */
@property (nonatomic, copy)NSString *nickName; //必填
/**
 *   @brief   用户头像
 */
@property (nonatomic, copy)NSString *avatarUrl; //选填
/**
 *   @brief   直播间id
 */
@property (nonatomic, copy)NSString *liveId; //必填
/**
 *   @brief   直播间enterCode
 */
@property (nonatomic, copy)NSString *enterCode; //必填


@end

NS_ASSUME_NONNULL_END
