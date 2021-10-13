//
//  BSYLiveChatMsgModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/17.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN
/**
  聊天消息类型
 */
typedef NS_ENUM(NSInteger, BSYLiveChatMsgType) {
    
    /**
     * 文本消息
     */
    BSYLiveChatMsgTypeText                   = 1,
    
    /**
     * 图片消息
     */
    BSYLiveChatMsgTypeImage                  = 2,
};

@class BSYLiveChatMsgTextElem;
@class BSYLiveChatMsgImageElem;

/**
   聊天消息
 */
@interface BSYLiveChatMsgModel : NSObject
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
/**
 *   @brief  昵称
 */
@property (nonatomic, strong, readonly)NSString *nickName;
/**
 *   @brief  头像地址
 */
@property (nonatomic, strong, readonly)NSString *avatarUrl;
/**
 *   @brief  时间戳
 */
@property (nonatomic, assign, readonly)uint64_t timestamp;
/**
 *   @brief  是否来源于剧本   true -来源于剧本    false-来源于聊天
 */
@property (nonatomic, assign, readonly)BOOL fromScript;

/**
 *   @brief 聊天消息中附加的自定义信息
 */
@property (nonatomic, strong, readonly)NSString *customPayloadData;

/**
 *   @brief 直播间静态透传附加的自定义信息
 */
@property (nonatomic, strong, readonly)NSString *customStaticData;


/**
 *   @brief  消息类型
 *   @see BSYLiveChatMsgType
 */
@property (nonatomic, assign, readonly)BSYLiveChatMsgType msgType;
/**
 *   @brief  文本消息内容 请参考：BSYLiveChatMsgTextElem
 */
@property (nonatomic, strong, readonly)BSYLiveChatMsgTextElem *textElem;
/**
 *   @brief  图片消息内容   请参考：BSYLiveChatMsgImageElem
 */
@property (nonatomic, strong, readonly)BSYLiveChatMsgImageElem *imageElem;


@end

NS_ASSUME_NONNULL_END
