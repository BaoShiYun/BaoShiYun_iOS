//
//  BSYLiveEventNotifyModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/12/2.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  通知类型
 */
typedef NS_ENUM(NSUInteger, BSYLiveEventNotifyType) {
    
    /**
     * 红包
     */
    BSYLiveEventNotifyType_RedPacket=1,
    
    /**
     * 购买
     */
    BSYLiveEventNotifyType_Purchase=2,
    
    /**
     * 自定义样式
     */
    BSYLiveEventNotifyType_Customize=3,
};

/**
  显示位置类型
 */
typedef NS_ENUM(NSUInteger, BSYLiveEventNotifyPosition) {
    
    /**
     * IM聊天区
     */
    BSYLiveEventNotifyPosition_ImMessage=1,
    
    /**
     * 弹幕
     */
    BSYLiveEventNotifyPosition_Barrage=2,
    
    /**
     * IM聊天和弹幕
     */
    BSYLiveEventNotifyPosition_BothImAndBarrage=3,
};


NS_ASSUME_NONNULL_BEGIN
@class BSYLiveNotifyTextStyleModel;

/**
 事件通知Model
 */
@interface BSYLiveEventNotifyModel : NSObject

/**
 *   @brief  所属群组id
 */
@property (nonatomic, assign, readonly)uint64_t groupId;

/**
 *   @brief  事件类型
 *   @see BSYLiveEventNotifyType
 *   @discussion  事件类型:BSYLiveEventNotifyType_RedPacket=领取红包事件， BSYLiveEventNotifyType_Purchase=为购买事件  模版{nickname}购买了{name}  {nickname}领取了红包{name} 3.自定义显示样式
 */
@property (nonatomic, assign, readonly)BSYLiveEventNotifyType eventType;

/**
 *   @brief  显示位置
 *   @see BSYLiveEventNotifyPosition
 */
@property (nonatomic, assign, readonly)BSYLiveEventNotifyPosition showPosition;

/**
 *   @brief  事件对应人昵称
 *   @discussion 仅支持：BSYLiveEventNotifyType_RedPacket、BSYLiveEventNotifyType_Purchase
 */
@property (nonatomic, strong, readonly)NSString *nickname;

/**
 *   @brief  事件操作模版信息
 *   @discussion 仅支持：BSYLiveEventNotifyType_RedPacket、BSYLiveEventNotifyType_Purchase
 */
@property (nonatomic, strong, readonly)NSString *templateMsg;

/**
 *   @brief  事件名
 *   @discussion 仅支持：BSYLiveEventNotifyType_RedPacket、BSYLiveEventNotifyType_Purchase
 */
@property (nonatomic, strong, readonly)NSString *name;

/**
 *   @brief  自定义样式内容
 *   @discussion 仅支持： BSYLiveEventNotifyType_Customize
 */
@property (nonatomic, strong, readonly)NSString *content;        ///
/**
 *   @brief  自定义样式内容  请参考：BSYLiveNotifyTextStyleModel
 *   @discussion 仅支持： BSYLiveEventNotifyType_Customize
 */
@property (nonatomic, strong, readonly)NSArray<BSYLiveNotifyTextStyleModel *> *contentTextStyleList;




@end

NS_ASSUME_NONNULL_END
