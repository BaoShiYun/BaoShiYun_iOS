//
//  BSYLiveDeleteChatMsgModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2021/7/20.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveDeleteChatMsgModel : NSObject

/**
 *   @brief  群id
 */
@property (nonatomic, assign, readonly)uint64_t groupId;

/**
 *   @brief  消息序列号云端生成，在群里是严格递增且唯一的
 */
@property (nonatomic, assign,readonly)uint64_t msgSeq;

/**
 *   @brief  抱石云ID，用户id转换后的抱石云uid （注：用于角色匹配使用）
 */
@property (nonatomic, strong, readonly)NSString *buid;

@end

NS_ASSUME_NONNULL_END
