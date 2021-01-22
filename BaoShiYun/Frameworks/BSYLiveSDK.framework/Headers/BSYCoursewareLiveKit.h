//
//  BSYCoursewareLiveKit.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/12/1.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class BSYLiveParam;
@class BSYLiveChatMsgModel;
@class BSYLiveKeywordsWinnerModel;
@class BSYLiveShelfModel;
@class BSYLiveLineModel;
@class BSYLiveResolutionModel;
@class BSYLiveEventNotifyModel;
@protocol  BSYCoursewareLiveKitDelegate;

@interface BSYCoursewareLiveKit : NSObject

@property (nonatomic, weak)id<BSYCoursewareLiveKitDelegate> delegate;


///———————————————————————————————————————————————————————
//
//                                  直播基础相关接口
//
///———————————————————————————————————————————————————————

/**
 *   @brief   初始化
 *   @param   containerView 承载视频画面的控件，设置完成后需要调整视频画面的大小只需要调整containerView大小即可
 */
- (instancetype)initWithPlayerContainerView:(UIView *)containerView;

/**
 *   @brief   登录直播间
 *   @param   liveParam 登录直播间参数 请参考:BSYLiveParam
 */
- (void)loginLiveWithParameter:(BSYLiveParam *)liveParam;

/**
 *   @brief   退出直播间
 *   说明:退出直播间后将停止聊天及直播视频播放
 */
- (void)logoutLive;


///———————————————————————————————————————————————————————
//
//                                  线路清晰度相关接口
//
////———————————————————————————————————————————————————————

/**
 * @brief 获取当前清晰度
 */
- (BSYLiveResolutionModel *)getCurrentLiveResolution;

/**
 * @brief 获取线路清晰度列表
 */
- (NSArray<BSYLiveResolutionModel *> *)getResolutionListWithLineId:(NSString *)lineId;

/**
 * @brief 获取当前线路
 */
- (BSYLiveLineModel *)getCurrentLiveLine;

/**
 * @brief 获取线路列表
 */
- (NSArray<BSYLiveLineModel *> *)getLiveLineList;

/**
 * @brief 刷新当前直播流
 */
- (void)refreshLiveSucc:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief   切换清晰度(保持线路不变)
 *   @param   resolution  清晰度标示
 */
- (void)switchResolution:(NSString *)resolution succ:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief   切换线路(保持清晰度不变)
 *   @param   lineId  线路id
 */
- (void)switchLineWithId:(NSString *)lineId succ:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;

/**
 *   @brief   切换线路及清晰度
 *   @param   lineId  线路id
 *   @param   resolution 清晰度标示
 */
- (void)switchLineWithId:(NSString *)lineId resolution:(NSString *)resolution succ:(BSYLiveKitSuccess __nullable)succ fail:(BSYLiveKitFail __nullable)fail;


////———————————————————————————————————————————————————————
//
//                                   课件模式相关
//
////———————————————————————————————————————————————————————
- (void)setCoursewarePlayerContainer:(UIView *)container;

- (void)refreshCoursewarePlayer;



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

@end





/*  ===================================== BSYLiveKitDelegate ======================================= */


@protocol BSYCoursewareLiveKitDelegate <NSObject>

///———————————————————————————————————————————————————————
//
//                                   直播基础相关回调
//
////———————————————————————————————————————————————————————

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
 *   @brief   禁言
 */
- (void)onRecvLiveRoomAllMuteStatus:(BOOL)isAllMute;

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


////———————————————————————————————————————————————————————
//
//                                   课件模式相关回调
//
////———————————————————————————————————————————————————————

/**
 *    @brief  回调当前是否为课件模式（两个播放窗口） 如果为课件模式可以调用 - (void)setCoursewarePlayerContainer:(UIView *)container; 设置课件视频播放窗口
 */

- (void)onRecvCoursewareMode:(BOOL)isCoursewareMode;

/**
 *    @brief  课件播放器准备直播
 */
- (void)onRecvCoursewareLivePreparePlaying;

/**
 *    @brief  课件播放器是否正在直播
 */
- (void)onRecvCoursewareLiveStatusPlaying:(BOOL)isPlaying;

/**
 *    @brief  课件播放器缓冲中
 */
- (void)onRecvCoursewareLiveStatusBuffering:(BOOL)isBuffering;

/**
 *    @brief  课件模式停止直播，normalEnd表示是否异常停止推流
 */
- (void)onRecvCoursewareLiveStatusChangeEnd:(BOOL)normalEnd;



///———————————————————————————————————————————————————————
//
//                               聊天消息相关回调
//
///———————————————————————————————————————————————————————

/**
 *     @brief  聊天消息
 */
- (void)onRecvChatMessage:(BSYLiveChatMsgModel *)msg;

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
 *     @brief  事件通知
 */
- (void)onRecvEventNotify:(BSYLiveEventNotifyModel *)eventNotify;


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

