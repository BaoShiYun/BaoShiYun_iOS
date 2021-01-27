//
//  BSYLiveUserInfo.h
//  BSYLiveSDK
//
//  Created by zddMac on 2021/1/26.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveUserInfo : NSObject

/**
 *   @brief   用户Uid
 */
@property (nonatomic, strong, readonly)NSString *userId; //用户ID
/**
 *   @brief   用户昵称
 */
@property (nonatomic, strong, readonly)NSString *nickName; //昵称
/**
 *   @brief   用户头像
 */
@property (nonatomic, strong, readonly)NSString *avatarUrl; //头像地址

@end

NS_ASSUME_NONNULL_END
