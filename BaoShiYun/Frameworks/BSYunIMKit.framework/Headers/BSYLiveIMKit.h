//
//  BSYLiveIMKit.h
//  BSYunIMKit
//
//  Created by zddMac on 2020/11/4.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSYIMKitDefine.h"
#import <BSYLiveDataLayer/BSYLiveDataLayer.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveIMTextMsgModel;
@class BSYLiveIMImageMsgModel;
@class BSYLiveCameraStreamStatusModel;
@class BSYLiveSwitchMasterCameraModel;
@protocol BSYLiveIMDelegate <NSObject>

@optional
//IM

//登录状态
- (void)onForceOffline;
- (void)onReConnFailed:(int)code err:(NSString*)err;
- (void)onUserSigExpired;


//连接状态
- (void)onConnSucc;
- (void)onConnFailed:(int)code err:(NSString*)err;
- (void)onDisconnect:(int)code err:(NSString*)err;
- (void)onConnecting;


//红包
- (void)recvRedPacketModel:(BSYLiveProtoKeywordsWinnerModel *)keywordsWinnerModel;
//评测
- (void)recvExamUrl:(NSString *)url;
//点赞
- (void)recvLikeTotalCount:(NSUInteger)totalCount newAddCount:(NSUInteger)addCount;
//禁言
- (void)recvLiveRoomAllMuteStatus:(BOOL)isAllMute;
//直播状态
- (void)recvLiveStatus:(BSYLiveStatus)liveStatus;
//直播状态
- (void)recvLiveRtcStatus:(BSYLiveStatus)liveStatus;
//在线人数
- (void)recvLiveOnlineCount:(NSUInteger)onlineCount;
//切换拉流地址
- (void)recvLiveMulitPullAddressChanged:(BSYLiveRouteModel *)routeModel;
//切换推流地址
- (void)recvLiveMulitPushAddressChanged:(BSYLiveProtoMulitPushAddressChangedModel *)pushRouteModel;
//机位推断流通知
- (void)recvLiveCameraStreamStatusChange:(BSYLiveCameraStreamStatusModel *)streamStatus;
//切换主机位
- (void)recvLiveMasterCameraSwitch:(BSYLiveSwitchMasterCameraModel *)cameraModel;
//课件模式直播开关
- (void)recvLiveCoursewareShow:(BOOL)showCourseware;

//通知信息 通知信息 购买/领取红包等
- (void)recvLiveEventNotify:(BSYLiveProtoGroupEventNotifyModel *)eventNotify;
//是否关闭在线人数显示
- (void)recvLiveOnlineNumDisplaySwitch:(BOOL)isDisplay;
//url链接
- (void)recvCommonUrl:(NSString *)url;
//显示货架
- (void)recvProductsOnShelf:(BSYLiveProtoGroupShelfShowModel *)shelfModel;
//隐藏货架
- (void)recvProductsOffShelf:(BSYLiveProtoGroupShelfHideModel *)shelfModel;

/************* 聊天信息 *******************/

//剧本直播
- (void)recvScriptMsg:(BSYLiveScriptMsgModel *)scriptMsgModel;

//直播群聊天消息
- (void)recvChatTextMsg:(BSYLiveIMTextMsgModel *)textMsg;
- (void)recvChatImageMsg:(BSYLiveIMImageMsgModel *)imgMsg;


@end


@class BSYLiveIMLoginParam;
@interface BSYLiveIMKit : NSObject

//@property (nonatomic, assign, readonly)BOOL isAllMute;
//@property (nonatomic, assign, readonly)BOOL isShowOnlineCount; //是否显示在线人数
//@property (nonatomic, assign, readonly)NSInteger onlineCount;  //是否显示在线人数

@property (nonatomic, weak)id<BSYLiveIMDelegate> delegate;
/**
 *   登录
*/

//登录
- (void)login:(BSYLiveIMLoginParam *)loginParam succ:(BSYIMSuccess __nullable)succ fail:(BSYIMFail __nullable)fail;
- (void)logout:(BSYIMSuccess __nullable)succ fail:(BSYIMFail __nullable)fail;
//获取用户信息
- (NSString *)getLoginUserId;
- (NSString *)getUserNickName;
//获取登录状态
- (BSYIMLoginStatus)getLoginStatus;

//添加点赞数
- (void)addLikeCount:(NSInteger)count;

- (int)getLastMessageSucc:(BSYIMGetMsgSuccess)succ fail:(BSYIMFail)fail;


/**
 *   消息
*/
//发送文本消息
- (void)sendTextMsg:(NSString *)text succ:(BSYIMSuccess __nullable)succ fail:(BSYIMFail __nullable)fail;


@end

NS_ASSUME_NONNULL_END
