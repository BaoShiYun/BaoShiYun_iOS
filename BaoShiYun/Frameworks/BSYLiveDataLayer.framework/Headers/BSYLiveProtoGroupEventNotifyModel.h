//
//  BSYLiveProtoGroupEventNotifyModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveProtoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BSYLiveGroupEventNotifyType) {
    
    BSYLiveGroupEventNotifyType_RedPacket=1, //红包
    BSYLiveGroupEventNotifyType_Purchase=2, //购买
    BSYLiveGroupEventNotifyType_Customize=3,//自定义样式
    
};

typedef NS_ENUM(NSUInteger, BSYLiveGroupEventNotifyPosition) {
    
    BSYLiveGroupEventNotifyPosition_ImMessage=1, //IM聊天区
    BSYLiveGroupEventNotifyPosition_Barrage=2, //弹幕
    BSYLiveGroupEventNotifyPosition_BothImAndBarrage=3, //IM聊天和弹幕
    
};

@class BSYLiveEventNotifyTextStyleModel;
@interface BSYLiveProtoGroupEventNotifyModel : BSYLiveProtoBaseModel

@property (nonatomic, strong)NSString *timGroupId;  // IMId
@property (nonatomic, assign)BSYLiveGroupEventNotifyType eventType;  //事件类型:1.领取红包事件， 2.为购买事件  模版{nickname}购买了{name}  {nickname}领取了红包{name} 3.自定义显示样式
@property (nonatomic, assign)BSYLiveGroupEventNotifyPosition showPosition; //显示位置
@property (nonatomic, assign)NSInteger showStyle;      //显示样式

@property (nonatomic, strong)NSString *content;        //自定义样式内容
@property (nonatomic, strong)NSArray<BSYLiveEventNotifyTextStyleModel *> *contentDetail;//自定义样式解析后内容


@property (nonatomic, strong)NSString *nickname;
@property (nonatomic, strong)NSString *templateMsg;
@property (nonatomic, strong)NSString *name;

@end

NS_ASSUME_NONNULL_END
