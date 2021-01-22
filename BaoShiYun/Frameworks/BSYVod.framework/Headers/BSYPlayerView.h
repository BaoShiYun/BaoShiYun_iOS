//
//  BSYPlayerView.h
//  BSYunVod
//
//  Created by Duane on 2020/10/27.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYVodVideoModel;
@class BSYDownloadModel;
@class BSYVodVideoQualityModel;

typedef NS_ENUM(NSUInteger, BSYPlayerViewTimeOut) {
    BSYPlayerViewStatusTimeOutLoad,//加载超时
    BSYPlayerViewStatusTimeOutBuffer //缓存超时
};

//无缓冲，立即播放相关设置
/** 该属性只对iOS10以上系统生效
 */
typedef NS_ENUM(NSUInteger, BSYPlayerViewLoadStyle) {
    BSYPlayerViewLoadStyleDefault, //会提前缓冲，缓冲一部分开始播放
    BSYPlayerViewLoadStyleImmediately //立即播放，无论先前是否进行过缓冲
};

@class BSYPlayerView;

@protocol BSYVideoPlayerDelegate <NSObject>

//所有的代理方法均已回到主线程 可直接刷新UI
@optional
/** 可播放
 @param playerView 自身对象
 */
-(void)videoPlayerIsReadyToPlayVideo:(BSYPlayerView *)playerView;

/** 播放完毕
 @param playerView 自身对象
 */
-(void)videoPlayerDidReachEnd:(BSYPlayerView *)playerView;

/** 获取播放进度
 @param playerView 自身对象
 @param time 当前播放时间
 */
-(void)videoPlayer:(BSYPlayerView *)playerView timeDidChange:(float)time;

/** 获取缓冲进度
 @param playerView 自身对象
 @param duration 当前缓冲进度
 */
-(void)videoPlayer:(BSYPlayerView *)playerView loadedTimeRangeDidChange:(float)duration;

/** 播放器缓存不足，播放卡顿
 @param playerView 自身对象
 */
-(void)videoPlayerPlaybackBufferEmpty:(BSYPlayerView *)playerView;

/** 播放器缓存充足，可继续播放
 @param playerView 自身对象
 */
-(void)videoPlayerPlaybackLikelyToKeepUp:(BSYPlayerView *)playerView;

/** 加载超时/scrub超时
 @param playerView 自身对象
 @param timeOut 超时类型
 */
-(void)videoPlayer:(BSYPlayerView *)playerView receivedTimeOut:(BSYPlayerViewTimeOut)timeOut;

/** 加载失败
 @param playerView 自身对象
 @param error 错误信息
 */
-(void)videoPlayer:(BSYPlayerView *)playerView didFailWithError:(NSError *)error;

/** AVPlayerLayer对象发生改变时回调
 @param playerView 自身对象
 @param playerLayer 新的AVPlayerLayer对象
 */
-(void)videoPlayer:(BSYPlayerView *)playerView ChangePlayerLayer:(AVPlayerLayer *)playerLayer;

@end

@interface BSYPlayerView : UIView

/**
 *  @brief 播放属性
 */
@property(nonatomic,strong,readonly)AVPlayer *player;

/**
 *  @brief 播放图层
 */
@property(nonatomic,strong,readonly)AVPlayerLayer *playerLayer;

/**
 *  @brief 代理
 */
@property(nonatomic,weak)id<BSYVideoPlayerDelegate> delegate;

/**
 *  @brief 当前播放状态
 */
@property(nonatomic,assign,readonly)BOOL playing;

/**
 *  @brief 是否静音，默认为NO
 */
@property(nonatomic,assign)BOOL muted;

/**
 *  @brief 是否循环播放，默认为NO
 */
@property(nonatomic,assign)BOOL looping;

/**
 *  @brief 视频加载超时时间，默认30s（逻辑待实现，暂时不生效）
 */
@property(nonatomic,assign)CGFloat timeOutLoad;

/**
 *  @brief 缓存超时时间，默认30s（逻辑待实现，暂时不生效）
 */
@property(nonatomic,assign)CGFloat timeOutBuffer;

/*!
 * @method
 * @abstract 获取当前已播放时间位置
 * @discussion 获取当前已播放时间位置
 * @result 获取当前已播放时间位置
 */
- (NSTimeInterval)currentPlaybackTime;

/*!
 * @method
 * @abstract 获取当前播放视频总时长
 * @discussion 获取当前播放视频总时长
 * @result 获取当前播放视频总时长
 */

- (NSTimeInterval)duration;


/*!
 * @method
 * @abstract 获取可播放的持续时间
 * @discussion 获取可播放的持续时间
 * @result 可播放的持续时间
 */
-(NSTimeInterval)playableDuration;

/**
 *  @brief 缓冲模式 默认DWPlayerViewLoadStyleDefault
 */
@property(nonatomic,assign)BSYPlayerViewLoadStyle loadStyle;

/**
 *  @brief 是否开启防录屏模式，默认为NO。仅对iOS11以上系统生效
 */
@property(nonatomic,assign)BOOL videoProtect;

/**
 *  @brief 视频填充模式，默认AVLayerVideoGravityResizeAspect
 */
@property(nonatomic,copy)NSString *videoGravity;

/**
 *  @brief 期待缓冲时长，默认0，建议取值1 ~ 50。仅对iOS10以上系统，m3u8格式视频有效
 */
@property(nonatomic,assign)NSTimeInterval forwardBufferDuration;

/**
 *  @brief 当前正在播放的媒体清晰度model，非在线视频返回nil。注意，在调用playVodViedo:withCustomId:方法后才可获取到此属性
 */
@property(nonatomic,strong,readonly)BSYVodVideoQualityModel * qualityModel;

/*!
 * @method
 * @abstract 播放网络视频
 * @discussion 播放默认清晰度
 * @param videoModel 在线视频model
 * @param customId 用户自定义参数，预留参数，传nil
 */
-(void)playVodViedo:(BSYVodVideoModel *)videoModel withCustomId:(nullable NSString *)customId;

/*!
 * @method
 * @abstract 播放本地视频
 * @discussion 播放本地视频
 * @param downloadModel 离线视频model
 */
-(void)playLocalVideo:(BSYDownloadModel *)downloadModel;

/*!
 * @method
 * @abstract 切换清晰度方法
 * @discussion 切换清晰度方法
 * @param qualitiyModel 清晰度model
 * @param customId 用户自定义参数，预留参数，传nil
 */
-(void)switchQuality:(BSYVodVideoQualityModel *)qualitiyModel withCustomId:(nullable NSString *)customId;

/*!
 * @method
 * @abstract 后台播放功能
 * @discussion 开启/关闭后台播放功能
 * @param play 是否允许后台播放
 */
-(void)setPlayInBackground:(BOOL)play;

/*!
 * @method
 * @abstract 切换倍速
 * @discussion 切换倍速
 * @param rate 倍速速率
 */
-(void)setPlayerRate:(float)rate;

/*!
 * @method
 * @abstract 播放
 * @discussion 播放当前媒体资源
 */
-(void)play;

/*!
 * @method
 * @abstract 暂停
 * @discussion 暂停当前媒体资源
 */
-(void)pause;

/*!
 * @method
 * @abstract 拖到XX秒播放视频
 * @discussion 在AVPlayerItemStatusReadyToPlay即状态处于可播放后，拖拽生效
 * @param time 跳转时间
 */
-(void)scrub:(float)time;

/*!
 * @method
 * @abstract 拖到XX秒播放视频
 * @discussion 在AVPlayerItemStatusReadyToPlay即状态处于可播放后，拖拽生效
 * @param time 跳转时间
 * @param completion 跳转完成回调
 */
-(void)scrubPrecise:(float)time CompletionHandler:(void(^)(BOOL finished))completion;

/*!
 * @method
 * @abstract 设置音量
 * @discussion 设置音量
 * @param volume 音量
 */
-(void)setVolume:(float)volume;

/*!
 * @method
 * @abstract 关闭|释放播放资源
 * @discussion 关闭|释放播放资源
 */
-(void)resetPlayer;

@end

NS_ASSUME_NONNULL_END
