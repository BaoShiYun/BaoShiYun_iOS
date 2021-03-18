//
//  BSYRtcRoomManager.h
//  BSYRtc
//
//  Created by Duane on 2020/11/16.
//

#import <Foundation/Foundation.h>
#import <BSYRtc/BSYRtcDef.h>

NS_ASSUME_NONNULL_BEGIN

// 进入RTC房间需要的参数
@interface BSYRtcRoomParams : NSObject

// 进入频道的id
@property (nonatomic, copy) NSString *channel;

// 进入频道需要的token
@property (nonatomic, copy, nullable) NSString *token;

// 用户的uid
@property (nonatomic, copy, nullable) NSString *uid;

// 主讲人的uid
@property (nonatomic, copy, nullable) NSString *anchorUid;

// 进入教室默认的角色，是否上麦
@property (nonatomic, assign) BSYRtcRole role;

@end

// RTC房间里的用户信息
@interface BSYRtcRoomUser : NSObject

// 用户的uid
@property (nonatomic, strong) NSString *uid;

// 用户画面的分辨率
@property (nonatomic, assign) CGSize videoSize;

// 用户的音量, 取值范围0 - 100
@property (nonatomic, assign) NSUInteger volume;

// 用户视频推流状态
@property (nonatomic, assign) BSYRtcVideoRemoteState videoState;

// 用户音频推流状态
@property (nonatomic, assign) BSYRtcAudioRemoteState audioState;

// 是否显示用户画面（如果是自己时表示是否发送自己的画面）
@property (nonatomic, assign) BOOL videoMuted;

// 是否播放用户声音（如果是自己时表示是否发送自己的声音）
@property (nonatomic, assign) BOOL audioMuted;

// 用户显示画面的画布
@property (strong, nonatomic, nullable) BSYRtcVideoCanvas *canvas;

@end

@protocol BSYRtcRoomManagerDelegate <NSObject>
@optional

// 发生错误通知
- (void)onError:(NSError *)error;

// 成功进入房间回调
- (void)didEnterRoom;

// 退出房间回调
- (void)didExitRoom;

// 本地用户状态变更通知
- (void)localUserStateChange;

// 主播状态变更通知
- (void)anchorUserStateChange;

// 远端用户列表变更通知
- (void)remoteUserListChange;

// 远端用户状态变更通知
- (void)remoteUserStateChange:(BSYRtcRoomUser *)user;

// 用户实时语音音量变化通知
- (void)userVolumeReport:(NSUInteger)volume userId:(NSString *)userId;

@end

@interface BSYRtcRoomManager : NSObject

@property (nonatomic, weak) id<BSYRtcRoomManagerDelegate> delegate;

// 本地用户在房间里的身份
@property (nonatomic, assign, readonly) BSYRtcRole role;

// 本地用户
@property (nonatomic, strong, readonly) BSYRtcRoomUser *localUser;

// 主播（根据进入房间参数BSYRtcRoomParams的anchorUid识别主播身份）
@property (nonatomic, strong, readonly) BSYRtcRoomUser *anchorUser;

// 其他远端用户
@property (nonatomic, strong, readonly) NSArray<BSYRtcRoomUser *> *remoteUsers;

+ (BSYRtcRoomManager *)defaultManager;

// 进入房间
- (void)enterRoom:(BSYRtcRoomParams *)params;

// 退出房间
- (void)exitRoom;

//切换身份，当role为BSYRtcRoleAnchor时上麦，当role为BSYRtcRoleAudience时下麦
- (void)switchRole:(BSYRtcRole)role;

// 是否关闭自己的音频
- (BOOL)muteLocalAudio:(BOOL)muted;

// 是否关闭自己的视频
- (BOOL)muteLocalVideo:(BOOL)muted;

// 是否接受远端用户的音频
- (BOOL)muteRemoteAudio:(NSString *)uid mute:(BOOL)muted;

// 是否接受远端用户的视频
- (BOOL)muteRemoteVideo:(NSString *)uid mute:(BOOL)muted;

@end

NS_ASSUME_NONNULL_END
