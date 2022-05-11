//
//  BSYVodVideoModel.h
//  BSYLiveDataLayerLibrary
//
//  Created by Duane on 2020/10/26.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYVodMediaRequest : BSYMediaModel

/**
 *  @brief 媒资ID
 */
@property(nonatomic, strong)NSString *mediaId;

/**
 *  @brief 媒资所属租户ID
 */
@property(nonatomic, assign)uintID tenantId;

/**
 *  @brief 用户ID
 */
@property(nonatomic, strong)NSString *userId;

/**
 *  @brief 视频token
 */
@property(nonatomic, strong)NSString *token;

@end

@interface BSYVodVideoQualityModel : BSYMediaModel

/**
 *  @brief 视频ID
 */
@property(nonatomic, strong, readonly)NSString *videoId;

/**
 *  @brief 扩展名
 */
@property(nonatomic, strong, readonly)NSString *extension;

/**
 *  @brief 分辨率，lud：超清，lhd：高清，lsd：标清
 */
@property(nonatomic, strong, readonly)NSString *resolution;

/**
 *  @brief 播放地址
 */
@property(nonatomic, strong, readonly)NSString *playURL;

/**
 *  @brief 文件大小（字节）
 */

@property (nonatomic, assign, readonly)UInt64 size;

/**
 *  @brief 时长(秒)
 */
@property (nonatomic, assign, readonly)CGFloat duration;


+(instancetype) alloc __attribute__((unavailable("video model create instance disabled")));
+(instancetype) new __attribute__((unavailable("video model create instance disabled")));
-(instancetype) copy __attribute__((unavailable("video model create instance disabled")));
-(instancetype) mutableCopy __attribute__((unavailable("video model create instance disabled")));

@end

@interface BSYVodVideoImageModel : BSYMediaModel

/**
 *  @brief 图片ID
 */
@property(nonatomic, strong, readonly)NSString *imageId;

/**
 *  @brief 扩展名
 */
@property(nonatomic, strong, readonly)NSString *extension;

/**
 *  @brief 图片地址
 */
@property(nonatomic, strong, readonly)NSString *showURL;

@end

@interface BSYVodVideoMediaMetaInfo : BSYMediaModel

/**
 *  @brief 视频资源组
 */
@property(nonatomic, strong, readonly)NSArray<BSYVodVideoQualityModel *> *videoGroup;

/**
 *  @brief 图片资源组
 */
@property(nonatomic, strong, readonly)NSArray<BSYVodVideoImageModel *> *imageGroup;

@end

/**
 *  媒资状态
 */
typedef NS_ENUM(NSInteger, BSYVodVideoStatus) {
    
    /**
     * 申请成功
     */
    BSYVodVideoStatus_Success = 0,
    
    /**
     * 处理中
     */
    BSYVodVideoStatus_Processing = 1,
    
    /**
     *  处理完成
     */
    BSYVodVideoStatus_Processed = 2,
    
    /**
     * 已发布
     */
    BSYVodVideoStatus_Published = 3,
    
    /**
     *  已停用
     */
    BSYVodVideoStatus_Disable = 4,
    
    /**
     * 已删除
     */
    BSYVodVideoStatus_Deleted = 5,
};

@interface BSYVodVideoModel : BSYMediaModel

/**
 *  @brief 媒资ID
 */
@property(nonatomic, strong, readonly)NSString *mediaId;

/**
 *  @brief 媒资名称
 */
@property(nonatomic, strong, readonly)NSString *title;

/**
 *  @brief 媒资描述信息
 */
@property(nonatomic, strong, readonly)NSString *desc;

/**
 *  @brief 媒资状态
 */
@property(nonatomic, assign, readonly)BSYVodVideoStatus status;

/**
 *  @brief 封面图地址
 */
@property(nonatomic, strong, readonly)NSString *coverImage;

/**
 *  @brief 媒体资源
 */
@property(nonatomic, strong, readonly)BSYVodVideoMediaMetaInfo *mediaMetaInfo;

/**
 *  @brief 创建时间
 */
@property(nonatomic, strong, readonly)NSDate *createTime;

/**
 *  @brief 媒资所属租户ID
 */
@property(nonatomic, assign)uintID tenantId;

/**
 *  @brief 用户ID
 */
@property(nonatomic, strong)NSString *userId;

/**
 *  @brief 视频token
 */
@property(nonatomic, strong)NSString *token;

@end

NS_ASSUME_NONNULL_END
