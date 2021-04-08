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
 - BSYLiveChatMsgTypeText: 文本消息
 - BSYLiveChatMsgTypeImage: 图片消息
 */
typedef NS_ENUM(NSInteger, BSYLiveChatMsgType) {
    BSYLiveChatMsgTypeText                   = 1,  ///< 文本消息
    BSYLiveChatMsgTypeImage                  = 2,  ///< 图片消息
};

@class BSYLiveChatMsgTextElem;
@class BSYLiveChatMsgImageElem;
@interface BSYLiveChatMsgModel : NSObject
@property (nonatomic, assign, readonly)uint64_t groupId; ///群id
@property (nonatomic, strong, readonly)NSString *userId; ///用户ID
@property (nonatomic, strong, readonly)NSString *nickName; ///昵称
@property (nonatomic, strong, readonly)NSString *avatarUrl; ///头像地址
@property (nonatomic, assign, readonly)uint64_t timestamp; ///时间戳
@property (nonatomic, assign, readonly)BOOL fromScript; //来源于剧本
@property (nonatomic, assign, readonly)BSYLiveChatMsgType msgType; ///消息类型
@property (nonatomic, strong, readonly)BSYLiveChatMsgTextElem *textElem; ///文本消息内容
@property (nonatomic, strong, readonly)BSYLiveChatMsgImageElem *imageElem; ///图片消息内容


@end

NS_ASSUME_NONNULL_END
