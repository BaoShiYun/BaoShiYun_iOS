//
//  BSYRtcRoomManager.h
//  BSYRtc
//
//  Created by Duane on 2020/11/16.
//

#import <Foundation/Foundation.h>
#import <BSYRtc/BSYRtcDef.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYRtcRoomParams : NSObject

@property (nonatomic, copy, nullable) NSString *channel;

@property (nonatomic, copy, nullable) NSString *token;

@property (nonatomic, copy, nullable) NSString *uid;

@property (nonatomic, copy, nullable) NSString *anchorUid;

@property (nonatomic, assign) BSYRtcRole role;

@end

@interface BSYRtcRoomUser : NSObject

// 用户的uid
@property (nonatomic, strong) NSString *uid;

// 用户画面的分辨率
@property (nonatomic, assign) CGSize videoSize;

// 用户视频推流状态
@property (nonatomic, assign) BSYRtcVideoRemoteState videoState;

// 是否显示用户画面
//@property (nonatomic, assign) BOOL videoMuted;

// 是否播放用户声音
//@property (nonatomic, assign) BOOL audioMuted;

@property (strong, nonatomic, nullable) BSYRtcVideoCanvas *canvas;

@end

@protocol BSYRtcRoomManagerDelegate <NSObject>
@optional

- (void)didEnterRoom;
- (void)onError:(NSError *)error;
- (void)didExitRoom;
- (void)localUserStateChange;
- (void)anchorUserStateChange;
- (void)remoteUserStateChange;

@end

@interface BSYRtcRoomManager : NSObject

@property (nonatomic, weak) id<BSYRtcRoomManagerDelegate> delegate;

@property (nonatomic, strong, readonly) NSArray<BSYRtcRoomUser *> *remoteUsers;
@property (nonatomic, strong, readonly) BSYRtcRoomUser *localUser;
@property (nonatomic, strong, readonly) BSYRtcRoomUser *anchorUser;

+ (BSYRtcRoomManager *)defaultManager;

- (void)enterRoom:(BSYRtcRoomParams *)params;
- (void)exitRoom;

@end

NS_ASSUME_NONNULL_END
