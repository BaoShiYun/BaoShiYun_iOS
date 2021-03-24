//
//  BSYLiveIMFaceCache.h
//  BaoShiYun
//
//  Created by zddMac on 2020/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef void (^BSYLiveAsyncImageComplete)(NSString *path, UIImage *image);

@class BSYLiveIMFaceGroup;
@interface BSYLiveIMFaceCache : NSObject


+ (instancetype)sharedInstance;

/**
 *  将表情添加进本地缓存中
 *
 *  @param path 本地缓存所在路径
 */
- (void)addFaceToCache:(NSString *)path;

/**
 *  从本地缓存获取表情资源
 *
 *  @param path 本地缓存所在路径
 */
- (UIImage *)getFaceFromCache:(NSString *)path;


- (NSMutableArray<BSYLiveIMFaceGroup *> *)getDefaultFaceGroups;


//清空内存中的表情列表
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
