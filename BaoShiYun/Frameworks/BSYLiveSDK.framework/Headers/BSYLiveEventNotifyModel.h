//
//  BSYLiveEventNotifyModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/12/2.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BSYLiveEventNotifyType) {
    
    BSYLiveEventNotifyType_RedPacket=1, //红包
    BSYLiveEventNotifyType_Purchase=2, //购买
    BSYLiveEventNotifyType_Customize=3,//自定义样式
    
};

typedef NS_ENUM(NSUInteger, BSYLiveEventNotifyPosition) {
    
    BSYLiveEventNotifyPosition_ImMessage=1, //IM聊天区
    BSYLiveEventNotifyPosition_Barrage=2, //弹幕
    BSYLiveEventNotifyPosition_BothImAndBarrage=3, //IM聊天和弹幕
};

NS_ASSUME_NONNULL_BEGIN
@class BSYLiveNotifyTextStyleModel;
@interface BSYLiveEventNotifyModel : NSObject
@property (nonatomic, assign, readonly)uint64_t groupId; // 群id
@property (nonatomic, assign, readonly)BSYLiveEventNotifyType eventType;  //事件类型:BSYLiveEventNotifyType_RedPacket=领取红包事件， BSYLiveEventNotifyType_Purchase=为购买事件  模版{nickname}购买了{name}  {nickname}领取了红包{name} 3.自定义显示样式
@property (nonatomic, assign, readonly)BSYLiveEventNotifyPosition showPosition; //显示位置

@property (nonatomic, strong, readonly)NSString *nickname;
@property (nonatomic, strong, readonly)NSString *templateMsg;
@property (nonatomic, strong, readonly)NSString *name;

@property (nonatomic, strong, readonly)NSString *content;        //自定义样式内容 BSYLiveEventNotifyType_Customize
@property (nonatomic, strong, readonly)NSArray<BSYLiveNotifyTextStyleModel *> *contentTextStyleList;//自定义样式解析后内容




@end

NS_ASSUME_NONNULL_END
