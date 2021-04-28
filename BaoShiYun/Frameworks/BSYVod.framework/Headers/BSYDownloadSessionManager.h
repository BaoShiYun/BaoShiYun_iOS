//
//  BSYDownloadSessionManager.h
//  BSYunVod
//
//  Created by zddMac on 2020/10/26.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYVodVideoModel;

@protocol BSYDownloadSessionManagerDelegate <NSObject>

@optional
/** 更新下载进度回调
 @param downloadModel 自身对象
 @param progress 下载进度
 */
-(void)downloadModel:(BSYDownloadModel *)downloadModel didUpdateProgress:(BSYDownloadProgress *)progress;

/** 更新下载状态
 @param downloadModel 自身对象
 @param state 下载状态
 @param error 错误信息 如果 state为BSYDownloadStateFailed 显示error信息
 */
-(void)downloadModel:(BSYDownloadModel *)downloadModel withState:(BSYDownloadState)state error:(NSError * __nullable)error;


@end



@interface BSYDownloadSessionManager : NSObject

/**
 *  @brief 下载的所有任务队列
 */
@property(nonatomic,strong,readonly)NSArray<BSYDownloadModel *>* downloadTaskList;

/**
 *  @brief 代理
 */
@property(nonatomic,weak)id<BSYDownloadSessionManagerDelegate> delegate;


/**
 *  @brief 是否允许使用移动流量 YES支持 NO不支持 默认支持
 */
@property(nonatomic,assign)BOOL allowsCellular;

/**
 *  @brief 全部并发，默认YES, 当YES时，忽略maxDownloadCount
 */
@property(nonatomic,assign)BOOL isBatchDownload;

/**
 *  @brief 允许同时下载的最大并发数,默认为1，最大为10
 */
@property(nonatomic,assign)NSInteger maxDownloadCount;

/*!
 * @method
 * @abstract 初始化BSYDownloadSessionManager
 * @discussion 初始化BSYDownloadSessionManager
 * @result BSYDownloadSessionManager对象
 */
+ (instancetype)sharedInstance;

/*!
 * @method
 * @abstract 配置下载数据存储目录，作为多用户下载数据区分
 * @param path  存储目录
 */
- (void)configBaseStorePath:(NSString *)path;

/*!
 * @method
 * @abstract 开始下载任务
 * @discussion 开始下载任务
 * @param downloadModel BSYDownloadModel对象
 */
-(void)addDownloadTask:(BSYDownloadModel *)downloadModel;

/*!
 * @method
 * @abstract 开始下载任务
 * @discussion 所有回调均已回到主线程中
 * @param downloadModel BSYDownloadModel对象
 * @param progressBlock 下载进度回调
 * @param stateBlock 下载状态变动回调
 */
-(void)addDownloadTask:(BSYDownloadModel *)downloadModel progress:(BSYDownloadProgressBlock __nullable)progressBlock state:(BSYDownloadStateBlock __nullable)stateBlock;

/*!
 * @method
 * @abstract 暂停下载任务
 * @discussion 暂停下载任务
 * @param downloadModel BSYDownloadModel对象
*/
-(void)suspendDownloadTask:(BSYDownloadModel *)downloadModel;

/*!
 * @method
 * @abstract 恢复下载任务
 * @discussion 恢复下载任务
 * @param downloadModel BSYDownloadModel对象
 */
-(void)resumeDownloadTask:(BSYDownloadModel *)downloadModel;

/*!
 * @method
 * @abstract 删除下载任务以及本地缓存
 * @discussion 删除下载任务以及本地缓存
 * @param downloadModel BSYDownloadModel对象
 */
-(void)deleteDownloadTask:(BSYDownloadModel *)downloadModel;

/*!
 * @method
 * @abstract 暂停全部任务
 * @discussion 暂停全部任务
 */
-(void)suspendAllDownloadTask;

/*!
 * @method
 * @abstract 删除全部任务
 * @discussion 删除全部任务
 */
-(void)deleteAllDownloadTask;

/*!
 * @method
 * @abstract 初始化BSYDownloadModel
 * @discussion 初始化BSYDownloadModel
 * @param videoModel 点播视频model，非空
 * @param resolution 媒体品质，非空 resolution:lud、lhd、lsd  分辨率：lud：超清，lhd：高清，lsd：标清
 * @result 创建成功返回BSYDownloadModel对象，如果失败，返回nil
 */
+(BSYDownloadModel *)createVideoDownloadModel:(BSYVodVideoModel *)videoModel withResolution:(NSString *)resolution;

/*!
 * @method
 * @abstract 获取下载模型
 * @discussion 获取下载模型
 * @param mediaId 视频id，非空
 * @result BSYDownloadModel对象
 */
-(NSArray<BSYDownloadModel *> *)getDownLoadVideoModelWithMediaId:(NSString *)mediaId;

/*!
 * @method
 * @abstract 获取下载模型
 * @discussion 获取下载模型
 * @param mediaId 视频id，非空
 * @param resolution 媒体品质，非空 resolution:lud、lhd、lsd  分辨率：lud：超清，lhd：高清，lsd：标清
 * @result BSYDownloadModel对象
 */
-(BSYDownloadModel *)getDownLoadVideoModelWithMediaId:(NSString *)mediaId withResolution:(NSString *)resolution;

/*!
 * @method
 * @abstract 判断当前资源是已在下载队列中
 * @discussion 判断当前资源是已在下载队列中
 * @param mediaId 视频id，非空
 * @param resolution 媒体品质，非空 resolution:lud、lhd、lsd  分辨率：lud：超清，lhd：高清，lsd：标清
 * @result 查询结果
 */
-(BOOL)checkLocalResourceWithMediaId:(NSString *)mediaId withResolution:(NSString *)resolution;


@end

NS_ASSUME_NONNULL_END
