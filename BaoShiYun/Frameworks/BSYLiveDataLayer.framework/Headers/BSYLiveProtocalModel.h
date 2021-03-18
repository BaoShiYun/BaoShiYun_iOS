//
//  BSYLiveProtocalModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

/* 系统群消息下发(历史消息不存在) */

//在线人数显示切换
#define BSYLiveProtoName_OnlineNumSwitch                     @"ONLINE_NUM_SWITCH"
//禁言
#define BSYLiveProtoName_GroupAllMute                        @"GROUP_SILENCE"
//点赞
#define BSYLiveProtoName_GroupLikeNum                        @"GROUP_LIKE_NUM"
//直播状态
#define BSYLiveProtoName_LiveStatusChanged                  @"LIVE_STATUS_CHANGED"
//心跳
#define BSYLiveProtoName_OnlineNum                          @"ONLINE_NUM"
//直播拉流地址切换
#define BSYLiveProtoName_PullAddressChanged                 @"PULL_ADDRESS_CHANGED"
//单/多机位拉流直播地址切换
#define BSYLiveProtoName_MulitPullAddressChanged            @"MULTI_PULL_ADDRESS_CHANGED"

//单/多机位推流直播地址切换
#define BSYLiveProtoName_MulitPushAddressChanged            @"MULTI_PUSH_ADDRESS_CHANGED"


//显示货架协议
#define BSYLiveProtoName_GroupShelfShow                     @"GROUP_SHELF_SHOW"
//隐藏货架协议
#define BSYLiveProtoName_GroupShelfHide                     @"GROUP_SHELF_HIDE"
//群事件通知协议
#define BSYLiveProtoName_GroupEventNotify                    @"GROUP_EVENT_NOTIFY"

//群通用控制协议
#define BSYLiveProtoName_GroupCommonControl                  @"GROUP_COMMON_CONTROL"

//直播间群信令通道
#define BSYLiveProtoName_LiveGroupMsg                        @"LIVE_GROUP_MSG_SENDER"


/* 群消息(历史消息存在) */
//评测
#define BSYLiveProtoName_TopicAsk                            @"TOPIC_ASK"
//群自定义消息(图片)
#define BSYLiveProtoName_CustomMsg                           @"CUSTOM_MSG"
//群发活动连接
#define BSYLiveProtoName_GroupUrlSender                      @"GROUP_URL_SENDER"

/*个人自定义消息*/
//红包
#define BSYLiveProtoName_KeywordsWinner                      @"KEYWORDS_WINNER"

//直播间单波信令通道
#define BSYLiveProtoName_LivePersonMsg                       @"LIVE_PERSON_MSG_SENDER"


@interface BSYLiveProtocalModel : BSYMediaModel

@property (nonatomic, strong)NSString *protoName;  //协议名称
@property (nonatomic, strong)NSString *ver; //协议版本
@property (nonatomic, strong)NSString *contentClass;    //内容class名字
@property (nonatomic, strong)id content;                //

@end

NS_ASSUME_NONNULL_END
