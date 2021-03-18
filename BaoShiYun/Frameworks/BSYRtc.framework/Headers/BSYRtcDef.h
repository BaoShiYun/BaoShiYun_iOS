//
//  BSYRtcDef.h
//  BSYRtc
//
//  Created by Duane on 2020/11/16.
//

#ifndef BSYRtcDef_h
#define BSYRtcDef_h

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
#import <UIKit/UIKit.h>
typedef UIView BSYView;
typedef UIImage BSYImage;
typedef UIEdgeInsets BSYEdgeInsets;
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
typedef NSView BSYView;
typedef NSImage BSYImage;
typedef NSEdgeInsets BSYEdgeInsets;
#endif

/**
 * Rtc服务商
 */
typedef NS_ENUM(NSInteger, BSYRtcServiceType) {
    BSYRtcServiceTypeAgora      =   0,   ///声网
    BSYRtcServiceTypeTrtc       =   1,   ///腾讯rtc
};

/**
 * 角色
 */
typedef NS_ENUM(NSInteger, BSYRtcRole) {
    BSYRtcRoleAnchor            =  0,   ///< 主播
    BSYRtcRoleAudience          =  1,   ///< 观众
};

/**
 * 视频画面填充模式
 */
typedef NS_ENUM(NSInteger, BSYRtcVideoFillMode) {
    BSYRtcVideoFillModeFill   = 0,  ///< 图像铺满屏幕，超出显示视窗的视频部分将被裁剪
    BSYRtcVideoFillModeFit    = 1,  ///< 图像长边填满屏幕，短边区域会被填充黑色
};

/**
 * 视频分辨率
 */
typedef NS_ENUM(NSInteger, BSYRtcVideoResolution) {
    // 宽高比1:1
    BSYRtcVideoResolution240_240     = 3,    ///< [C] 建议码率 VideoCall:100kbps  LIVE:150kbps
    BSYRtcVideoResolution480_480     = 7,    ///< [C] 建议码率 VideoCall:350kbps  LIVE:120kbps
    
    // 宽高比4:3
    BSYRtcVideoResolution320_240     = 56,   ///< [C] 建议码率 VideoCall:250kbps  LIVE:375kbps
    BSYRtcVideoResolution640_480     = 62,   ///< [C] 建议码率 VideoCall:600kbps  LIVE:900kbps
    BSYRtcVideoResolution960_720     = 64,   ///< [C] 建议码率 VideoCall:1000kbps LIVE:1500kbps
    
    // 宽高比16:9
    BSYRtcVideoResolution320_180     = 104,  ///< [C] 建议码率 VideoCall:250kbps  LIVE:400kbps
    BSYRtcVideoResolution640_360     = 108,  ///< [C] 建议码率 VideoCall:550kbps  LIVE:900kbps
    BSYRtcVideoResolution1280_720    = 112,  ///< [C] 建议码率 VideoCall:1200kbps LIVE:1800kbps
};

/**
 * 本地视频预览镜像类型
 */
typedef NS_ENUM(NSUInteger, BSYRtcLocalVideoMirrorType) {
    BSYRtcLocalVideoMirrorTypeAuto       = 0,       ///< 前置摄像头镜像，后置摄像头不镜像
    BSYRtcLocalVideoMirrorTypeEnable     = 1,       ///< 前后置摄像头画面均镜像
    BSYRtcLocalVideoMirrorTypeDisable    = 2,       ///< 前后置摄像头画面均不镜像
};

/**
 * 视频流类型
 */
typedef NS_ENUM(NSInteger, BSYRtcVideoStreamType) {
    BSYRtcVideoStreamTypeHight   = 0,     ///< 主画面视频流
    BSYRtcVideoStreamTypeLow = 1,     ///< 小画面视频流
};

/**
 * 声音音质
 */
typedef NS_ENUM(NSInteger, BSYRtcAudioQuality) {
    /// 16k；单声道；适合语音通话为主的场景，比如在线会议，语音通话。
    BSYRtcAudioQualitySpeech = 1,
    /// 48k；单声道；默认的音频质量，
    BSYRtcAudioQualityDefault = 2,
    /// 128k；双声道；适合需要高保真传输音乐的场景，比如K歌、音乐直播等。
    BSYRtcAudioQualityMusic = 3,
};

/**
 * 声音播放模式（音频路由）
 */
typedef NS_ENUM(NSInteger, BSYRtcAudioRoute) {
    BSYRtcAudioRouteDefault       =  -1,   ///<Default
    BSYRtcAudioRouteSpeakerphone  =   0,   ///< 扬声器
    BSYRtcAudioRouteEarpiece      =   1,   ///< 听筒
};

/**
 * 网络质量
 */
typedef NS_ENUM(NSInteger, BSYRtcNetworkQuality) {
    BSYRtcNetworkQualityUnknown     = 0,     ///< 未定义
    BSYRtcNetworkQualityExcellent   = 1,     ///< 最好
    BSYRtcNetworkQualityGood        = 2,     ///< 好
    BSYRtcNetworkQualityPoor        = 3,     ///< 一般
    BSYRtcNetworkQualityBad         = 4,     ///< 差
    BSYRtcNetworkQualityVbad        = 5,     ///< 很差
    BSYRtcNetworkQualityDown        = 6,     ///< 不可用
    BSYRtcNetworkQualityUnsupported = 7,     ///< 不支持检测
    BSYRtcNetworkQualityDetecting   = 8,     ///< 检测中
};

/**
 * 连接状态
 */
typedef NS_ENUM(NSInteger, BSYRtcConnectionState) {
    BSYRtcConnectionStateDisconnected = 1,
    BSYRtcConnectionStateConnecting = 2,
    BSYRtcConnectionStateConnected = 3,
    BSYRtcConnectionStateReconnecting = 4,
    BSYRtcConnectionStateFailed = 5,
};

/**
 * 远端用户视频推流状态
 */
typedef NS_ENUM(NSUInteger, BSYRtcVideoRemoteState) {
    BSYRtcVideoRemoteStateStopped = 0, // 推流停止
    BSYRtcVideoRemoteStateStarting = 1, // 开始推流
    BSYRtcVideoRemoteStateDecoding = 2, // 推流中
    BSYRtcVideoRemoteStateFrozen = 3, // 推流中断
    BSYRtcVideoRemoteStateFailed = 4, // 推流失败
};

/**
 * 远端用户音频推流状态
 */
typedef NS_ENUM(NSUInteger, BSYRtcAudioRemoteState) {
    BSYRtcAudioRemoteStateStopped = 0, // 推流停止
    BSYRtcAudioRemoteStateStarting = 1, // 开始推流
    BSYRtcAudioRemoteStateDecoding = 2, // 推流中
    BSYRtcAudioRemoteStateFrozen = 3, // 推流中断
    BSYRtcAudioRemoteStateFailed = 4, // 推流失败
};

@interface BSYRtcConfig : NSObject

@property (nonatomic, copy, nullable) NSString *appId;

@end

@interface BSYRtcParams : NSObject

@property (nonatomic, copy, nullable) NSString *uid;
@property (nonatomic, copy, nullable) NSString *channel;
@property (nonatomic, copy, nullable) NSString *token;

@end

@interface BSYRtcVideoCanvas : NSObject

@property (nonatomic, strong, nullable) BSYView *view;

@property (nonatomic, assign) BSYRtcVideoFillMode fillMode;

@property (nonatomic, copy, nullable) NSString *channel;

@property (nonatomic, copy, nullable) NSString *uid;

@end

@interface BSYRtcVideoEncParam : NSObject

///视频分辨率
@property (nonatomic, assign) BSYRtcVideoResolution resolution;
///视频采集帧率
@property (nonatomic, assign) int fps;
///目标视频码率
@property (nonatomic, assign) int bitrate;
///最低视频码率
@property (nonatomic, assign) int minBitrate;

@end

@interface BSYRtcVolumeInfo : NSObject <NSCopying>

/// 说话者的 userId, nil 为自己
@property (nonatomic, strong, nullable) NSString *userId;
/// 说话者的音量, 取值范围0 - 100
@property (nonatomic, assign) NSUInteger volume;

@end

@interface BSYRtcVideoInfo : NSObject <NSCopying>

/// 视频的 userId, nil 为自己
@property (nonatomic, strong, nullable) NSString *userId;
/// 视频流分辨率宽度
@property (assign, nonatomic) NSUInteger width;
/// 视频流分辨率高度
@property (assign, nonatomic) NSUInteger height;

@end

#endif /* BSYRtcDef_h */
