//
//  BSYDownloadModel.h
//  BSYunVod
//
//  Created by zddMac on 2020/10/26.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN


@class BSYDownloadModel;
@class BSYDownloadProgress;

/**
 * @brief  进度更新回调
 */
typedef void (^BSYDownloadProgressBlock)(BSYDownloadModel *downloadModel, BSYDownloadProgress *progress);


/**
 * @brief  状态更新回调
 */
typedef void (^BSYDownloadStateBlock)(BSYDownloadModel *downloadModel, NSError *error);


/**
  离线下载
 */
@interface BSYDownloadModel : NSObject

/**
 *  @brief 资源id
*/
@property (nonatomic, strong, readonly)NSString *mediaId;

/**
 *  @brief  视频id
*/
@property (nonatomic, strong, readonly)NSString *videoId;

/**
 *  @brief 文件名
 */
@property(nonatomic, strong, readonly)NSString * fileName;

/**
 * @brief 文件下载地址
*/
@property(nonatomic, strong, readonly)NSString *downloadUrl;


/**
 *  @brief 存储路径
 */
@property(nonatomic, strong, readonly)NSString * filePath;

/**
 *  @brief 下载状态
 */
@property(nonatomic, assign, readonly)BSYDownloadState state;

/**
 *  @brief 资源类型
*/
@property (nonatomic, assign, readonly)BSYDownloadType type;


/**
 *  @brief 文件大小
*/
@property (nonatomic, assign, readonly)UInt64 fileSize;

/**
 *  @brief 下载进度  请参考：BSYDownloadProgress
 */
@property(nonatomic, strong ,readonly)BSYDownloadProgress *progress;


/**
 *  @brief 下载进度更新回调
 *  @see BSYDownloadProgressBlock
 */
@property(nonatomic, copy)BSYDownloadProgressBlock progressBlock;

/**
 *  @brief 下载状态更新
 *  @see BSYDownloadStateBlock
 */
@property(nonatomic, copy)BSYDownloadStateBlock stateBlock;


/**
 *  @brief 分辨率，lud、lhd、lsd
 *  @discussion lud：超清，lhd：高清，lsd：标清
 */
@property(nonatomic, strong, readonly)NSString *resolution;


/**
 *  @brief 分辨率，超清、高清、标清
 *  @discussion lud：超清，lhd：高清，lsd：标清
 */
@property(nonatomic, strong, readonly)NSString *resolutionDes;





@end



/**
  下载进度
 */
@interface BSYDownloadProgress : NSObject


/**
 *  @brief 下载进度
 */
@property(nonatomic, assign, readonly)float progress;

/**
 *  @brief 下载速度
 */
@property(nonatomic, assign, readonly)float speed;

/**
 *  @brief 文件的总大小
 */
@property(nonatomic, assign, readonly)int64_t fileSize;


@end



NS_ASSUME_NONNULL_END
