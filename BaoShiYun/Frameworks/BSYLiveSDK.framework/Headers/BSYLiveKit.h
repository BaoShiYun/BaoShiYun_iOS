//
//  BSYLiveKit.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/12.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveParam;
@class BSYLiveUserInfo;
@class BSYLiveChatMsgModel;
@class BSYLiveKeywordsWinnerModel;
@class BSYLiveShelfModel;
@class BSYLiveLineModel;
@class BSYLiveResolutionModel;
@class BSYLiveEventNotifyModel;
@class BSYLiveInteractiveConfigModel;
@class BSYLiveBroadcastUserModel;
@protocol  BSYLiveKitDelegate;

@interface BSYLiveKit : NSObject

@property (nonatomic, weak)id<BSYLiveKitDelegate> delegate;


///———————————————————————————————————————————————————————
//
//                                  直播基础相关接口
//
///———————————————————————————————————————————————————————

/**
 *   @brief   初始化
 *   @param   liveParam 登录直播间参数 请参考:BSYLiveParam
 */
- (instancetype)initWithParameter:(BSYLiveParam *)liveParam;

/**
 *   @brief   设置直播间主窗口 主要承载Rtc直播间老师的屏幕共享，Live直播间的视频画面
 *   @param   mainView 承载讲师屏幕共享或主画面的控件，设置完成后需要调整视频画面的大小只需要调整containerView大小即可
 */
- (void)setMainVideoContainerView:(UIView *)mainView;

/**
 *   @brief   登录直播间
 */
- (void)loginLive;

/**
 *   @brief   退出直播间
 *   说明:退出直播间后将停止聊天及直播视频播放
 */
- (void)logoutLive;

/**
 *   @brief   获取直播间名
 *   说明：直播间登录成功后有效
 */
- (NSString *)getLiveName;

/**
 *   @brief   判段直播间是否为Rtc或者为Live   返回值Yes=Rtc  NO=Live
 *   说明：直播间登录成功后有效
 */
- (BOOL)isRtcLive;




///———————————————————————————————————————————————————————
//
//                                  线路清晰度相关接口
//
////———————————————————————————————————————————————————————

/**
 * @brief 获取当前清晰度 仅Live直播
 */
- (BSYLiveResolutionModel *)getCurrentLiveResolution;

/**
 * @brief 获取线路清晰度列表 仅Live直播
 */
- (NSArray<BSYLiveResolutionModel *> *)getResolutionListWithLineId:(NSString * __nullable)lineId;

/**
 * @brief 获取当前线路 仅Live直播
 */
- (BSYLiveLineModel *)getCurrentLiveLine;

/**
 * @brief 获取线路列表 仅Live直播
 */
- (NSArray<BSYLiveLineModel *> *)getLiveLineList;

/**
 * @brief 刷新当前直播流
 */
- (void)refreshLiveSucc:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief   切换清晰度(保持线路不变)  仅Live直播
 *   @param   resolution  清晰度标示
 */
- (void)switchResolution:(NSString *)resolution succ:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief   切换线路(保持清晰度不变) 仅Live直播
 *   @param   lineId  线路id
 */
- (void)switchLineWithId:(NSString *)lineId succ:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief   切换线路及清晰度 仅Live直播
 *   @param   lineId  线路id
 *   @param   resolution 清晰度标示
 */
- (void)switchLineWithId:(NSString *)lineId resolution:(NSString *)resolution succ:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;



////———————————————————————————————————————————————————————
//
//                                   白板相关
//
////———————————————————————————————————————————————————————

/**
 *   @brief   设置白板容器
 *   @param   container  白板容器  备注：确定传入的 container 已经添加在 ViewController 的视图栈中。否则 iOS 12 开始，无法正确初始化，且不会有任何错误反馈，
 *   且 ViewController  添加    if (@available(iOS 11, *)) {} else {self.automaticallyAdjustsScrollViewInsets = NO; }
 */

- (void)setWhiteboardContainer:(UIView *)container;

- (void)quitWhiteboard;


///———————————————————————————————————————————————————————
//
//                               直播上麦相关
//
///———————————————————————————————————————————————————————

/**
 *   @brief  设置老师的摄像头父View
 *   @param containerView   承载的父视图View
 */
- (void)setTeacherVideoContainerView:(UIView *)containerView;

/**
 *   @brief  移除自己的摄像头父View
 *
 */
- (void)removeTeacherVideoContainerView;
/**
 *   @brief  设置自己的摄像头父View
 *   @param containerView   承载的父视图View
 */
- (void)setSelfBroadcastVideoContainerView:(UIView *)containerView;
/**
 *   @brief  移除自己的摄像头父View
 *
 */
- (void)removeSelfBroadcastVideoContainerView;

/**
 *   @brief  当前是摄像头被禁用
 *   @return Yes-禁用  NO-不禁用
 */
- (BOOL)getSelfBroadcastVideoDisable;

/**
 *   @brief  当前是否麦克风被禁用
 *   @return Yes-禁用  NO-不禁用
 */
- (BOOL)getSelfBroadcastAudioDisable;


/**
 *   @brief  当前摄像头是否关闭
 *   @return Yes-关闭  NO-开启
 */
- (BOOL)getSelfBroadcastVideoMute;

/**
 *   @brief  当前麦克风是否关闭
 *   @return Yes-关闭  NO-开启
 */
- (BOOL)getSelfBroadcastAudioMute;


/**
 *   @brief  设置其他连麦用户的摄像头父View
 *   @param uid   用户id
 *   @param containerView   承载的父视图View
 */
- (void)setRemoteUserVideoContainerViewWithUid:(NSString *)uid containerView:(UIView *)containerView;


/**
 *   @brief  移除其他连麦用户的摄像头父View
 *   @param uid   用户id
 */
- (void)removeRemoteUserVideoContainerViewWithUid:(NSString *)uid;


/**
 *   @brief   rtc互动直播举手请求，老师确认后自动上麦互动
 *
 */
- (void)raiseHandRequestSucc:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief   取消当前举手等待。当老师长时间未响应学生举手请求，学生可以主动取消举手
 *
 */
- (void)cancelRaiseHandSucc:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief  确认是否同意点名，同意后学生将上麦互动。如果老师未点名则调用无效
 *   @param  isAgree   是否同意老师的点名 Yes=同意   NO=拒绝
 *   @param  teacherId   发起点名的老师uid 回传回去，用于通知老师我的同意结果
 */
- (void)confirmInvitBroadcast:(BOOL)isAgree withTeacherId:(NSString *)teacherId succ:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief  停止连麦互动 如果当前用户未连麦，则设置无效，返回失败
 */
- (void)disConnectBroadcastSucc:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief 用户上麦情况下，设置自己麦克风、摄像头开启状态。如果当前用户未上麦，则设置无效
 *   @param  isVideoMute   摄像头是否开启 Yes=开启   NO=关闭
 */
- (void)modifyBroadcastMuteVideo:(BOOL)isVideoMute;

/**
 *   @brief 用户上麦情况下，设置自己麦克风、摄像头开启状态。如果当前用户未上麦，则设置无效
 *   @param  isAudioMute         麦克风是否开启 Yes=开启   NO=关闭
 */
- (void)modifyBroadcastMuteAudio:(BOOL)isAudioMute;

////———————————————————————————————————————————————————————
//
//                                   直播业务相关
//
////———————————————————————————————————————————————————————

/**
 *   @brief   发送新增点赞数
 *   @param   count  新增点赞数
 */
- (void)addLikeCount:(NSInteger)count;


///———————————————————————————————————————————————————————
//
//                                  聊天消息相关接口
//
///———————————————————————————————————————————————————————

/**
 *   @brief   发送直播群聊天文本消息
 *   @param   text  文本内容
 */
- (void)sendTextMsg:(NSString *)text  succ:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief  获取im历史记录 每次20条
 */

- (int)getLastMessageHistorySucc:(BSYLiveKitIMGetMsgSuccess)succ fail:(BSYLiveKitFail __nullable)fail;


///———————————————————————————————————————————————————————
//
//                                  评测相关接口
//
///———————————————————————————————————————————————————————

/**
 *   @brief  获取问答列表
 */
- (void)getQuestionListSucc:(BSYLiveKitQuestionListSuccess)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief  获取问答Token 仅支持使用抱石云TES
 */
- (void)getQuestionTokenSucc:(BSYLiveKitQuestionTokenSuccess)succ fail:(BSYLiveKitFail __nullable)fail;

///———————————————————————————————————————————————————————
//
//                                  活动相关接口
//
///———————————————————————————————————————————————————————

/**
 *   @brief  获取红包列表
 */
- (void)getActivityListSucc:(BSYLiveKitActivityListSuccess)succ fail:(BSYLiveKitFail __nullable)fail;


@end





/*  ===================================== BSYLiveKitDelegate ======================================= */


@protocol BSYLiveKitDelegate <NSObject>

///———————————————————————————————————————————————————————
//
//                                   直播基础相关回调
//
////———————————————————————————————————————————————————————

@optional;
/**
 *   @brief   登录成功
 */
- (void)loginSuccess;

/**
 *   @brief   登录失败
 */
- (void)loginFail:(NSInteger)code message:(NSString *)msg;

/**
 *   @brief   强制被踢下线
 *   说明:强制踢下线后，如需继续使用直播间，则需要重新登录
 */
- (void)onRecvForceOffline;

/**
 *   @brief   直播间sig过期 需重新登录
 *   说明:sig过期后，如需继续使用直播间，则需要重新登录
 */
- (void)onRecvUserSigExpired;


/**
 *   @brief 直播间登录的用户信息
 *
 */
- (void)onRecvLiveUserInfo:(BSYLiveUserInfo *)userInfo;

/**
 *   @brief 角色列表
 *   roleList 内容结构
 *   [
 *      {
 *        uid,
 *        roleType 1=老师 2=助教 3=班主任 4=管理员,
 *      }
 *   ]
 */
- (void)onRecvLiveRoleList:(NSArray *)roleList;

/**
 *   @brief   是否关闭在线人数显示 isDisplay=YES(显示) isDisplay=NO(不显示，同时“在线人数”将变为0)
 */
- (void)onRecvLiveOnlineCountDisplay:(BOOL)isDisplay;

/**
 *   @brief   在线人数
 */
- (void)onRecvLiveOnlineCount:(NSUInteger)onlineCount;

/**
 *   @brief   点赞总数及新增点赞数
 */
- (void)onRecvLikeTotalCount:(NSUInteger)totalCount newAddCount:(NSUInteger)addCount;

/**
 *   @brief   全体禁言
 */
- (void)onRecvLiveRoomAllMuteStatus:(BOOL)isAllMute;

/**
 *   @brief  直播间介绍
 */

- (void)onRecvLiveIntroduceUrl:(NSString *)Url;

///———————————————————————————————————————————————————————
//
//                               直播状态相关回调
//
///———————————————————————————————————————————————————————

/**
 *    @brief  主讲开始推流
 */
- (void)onRecvLiveStatusChangeStart;
/**
 *    @brief  停止直播，normalEnd表示是否异常停止推流
 */
- (void)onRecvLiveStatusChangeEnd:(BOOL)normalEnd;

/**
 *    @brief  准备直播直播
 */
- (void)onRecvLivePreparePlaying;

/**
 *    @brief  是否正在直播
 */
- (void)onRecvLiveStatusPlaying:(BOOL)isPlaying;

/**
 *    @brief  缓冲中
 */
- (void)onRecvLiveStatusBuffering:(BOOL)isBuffering;

/**
 *    @brief  当前线路及清晰度回调
 */
- (void)onRecvCurrentLiveLine:(BSYLiveLineModel *)lineModel resolution:(BSYLiveResolutionModel *)resolutionModel;


///———————————————————————————————————————————————————————
//
//                               白板相关回调
//
///———————————————————————————————————————————————————————

/**
 *    @brief  回调当前是否为课件模式， 如果为课件模式可以调用 - (void)setWhiteboardContainer:(UIView *)container; 设置白板窗口
 */

- (void)onRecvWhiteboardMode:(BOOL)hasWhiteboard;

/**
 *     @brief  聊天消息
 */
- (void)onRecvChatMessage:(BSYLiveChatMsgModel *)msg;


///———————————————————————————————————————————————————————
//
//                               直播上麦相关回调
//
///———————————————————————————————————————————————————————


/**
 *     @brief  互动直播间互动类型
 */
- (void)onRecvLiveInteractiveType:(BSYLiveInteractiveType)interactiveType;


/**
 *    @brief 老师麦克风关闭
 *    @param audioMute   Yes=关闭    NO=开启
 */
- (void)onRecvTeacherAudioMute:(BOOL)audioMute;

/**
 *    @brief 老师摄像头关闭
 *    @param videoMute   Yes=关闭    NO=开启
 */
- (void)onRecvTeacherVideoMute:(BOOL)videoMute;


/**
 *    @brief 老师麦克风音量变化
 *    @param volumeValue  麦克风音量值  0-100
 */
- (void)onRecvTeacherVolumeChange:(NSUInteger)volumeValue;

/**
 *    @brief  收到上麦邀请。收到邀请后需要调用【- (void)confirmInvitBroadcast:(BOOL)isAgree withTeacherId:(NSString *)teacherId succ:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;】确认是否上麦。如果确定上麦则调用【】设置承载自己视频窗口View
 */
- (void)onRecvInvitBroadcastFromTeacherUid:(NSString *)uid;

/**
 *    @brief 自己连麦状态变更通知
 *    @param isConnect   Yes=已连接    NO=未连接
 *    @param reasonType   详细查看 BSYLiveInteractiveStatusReasonType 定义
 */
- (void)onRecvSelfBroadcastConnectChangeStatus:(BOOL)isConnect  withReasonType:(BSYLiveInteractiveStatusReasonType)reasonType;

/**
 *    @brief 自己举手状态变更通知
 *    @param isRaiseHand   Yes=已连接    NO=未连接
 *    @param reasonType   详细查看 BSYLiveInteractiveStatusReasonType 定义
 */
- (void)onRecvSelfRaiseHandChangeStatus:(BOOL)isRaiseHand withReasonType:(BSYLiveInteractiveStatusReasonType)reasonType;


/**
 *    @brief 全员禁用麦克风，由老师端设置
 *    @param allAudioDisable   Yes=全员禁麦    NO=取消全员禁麦
 */
- (void)onRecvAllBroadcastAudioDisable:(BOOL)allAudioDisable;



/**
 *    @brief 麦克风被禁用，由老师端设置
 *    @param audioDisable   Yes=禁麦。 NO=取消禁麦
 */
- (void)onRecvSelfBroadcastAudioDisable:(BOOL)audioDisable;

/**
 *    @brief 摄像头被禁用，由老师端设置
 *    @param videoDisable   Yes=禁用摄像头。 NO=取消禁用摄像头
 */
- (void)onRecvSelfBroadcastVideoDisable:(BOOL)videoDisable;

/**
 *    @brief 麦克风关闭
 *    @param audioMute   Yes=关闭    NO=开启
 */
- (void)onRecvSelfBroadcastAudioMute:(BOOL)audioMute;


/**
 *    @brief 摄像头关闭
 *    @param videoMute   Yes=关闭    NO=开启
 */
- (void)onRecvSelfBroadcastVideoMute:(BOOL)videoMute;

/**
 *    @brief 自己麦克风音量变化
 *    @param volumeValue  麦克风音量值  0-100
 */
- (void)onRecvSelfBroadcastVolumeChange:(NSUInteger)volumeValue;

/**
 *    @brief 其他连麦用户麦克风关闭
 *    @param audioMute   Yes=关闭    NO=开启
 */
- (void)onRecvRemoteBroadcastAudioMute:(BOOL)audioMute withUid:(NSString *)uid;


/**
 *    @brief 其他连麦用户摄像头关闭
 *    @param videoMute   Yes=关闭    NO=开启
 */
- (void)onRecvRemoteBroadcastVideoMute:(BOOL)videoMute withUid:(NSString *)uid;



/**
 *    @brief 其他连麦用户麦克风音量变化
 *    @param uid   用户Id
 *    @param volumeValue  麦克风音量值  0-100
 */
- (void)onRecvRemoteBroadcastVolumeChangeWithUid:(NSString *)uid volumeValue:(NSUInteger)volumeValue;

/**
 *    @brief 其他用户连麦列表变更通知 （其他用户：除老师和自己外其他连麦用户）
 *    @param remoteUserList   其他连麦用户信息列表
 */
- (void)onRecvRemoteBroadcastUserListChange:(NSArray<BSYLiveBroadcastUserModel *> * __nullable)remoteUserList;


///———————————————————————————————————————————————————————
//
//                                 业务工具相关回调
//
///———————————————————————————————————————————————————————

/**
 *     @brief  评测
 */
- (void)onRecvExamUrl:(NSString *)url;

/**
 *     @brief  url链接
 */
- (void)onRecvCommonUrl:(NSString *)url;

/**
 *     @brief   通知
 */

- (void)onRecvEventNotify:(BSYLiveEventNotifyModel *)notifyModel;


///———————————————————————————————————————————————————————
//
//                                 直播带货相关回调
//
///———————————————————————————————————————————————————————
/**
 *     @brief  红包/口令红包
 */
- (void)onRecvRedPacketUrl:(NSString *)url;

/**
 *     @brief    显示货架
 */
- (void)onRecvProductsOnShelf:(BSYLiveShelfModel *)shelfModel;

/**
 *     @brief   隐藏货架
 */
- (void)onRecvProductsOffShelf:(BSYLiveShelfModel *)shelfModel;



@end


NS_ASSUME_NONNULL_END
