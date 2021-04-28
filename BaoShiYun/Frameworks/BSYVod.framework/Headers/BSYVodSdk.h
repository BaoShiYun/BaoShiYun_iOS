//
//  BSYVodSdk.h
//  BSYVod
//
//  Created by zddMac on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYVodSdk : NSObject

@property(class, nonatomic, strong, readonly)NSString *token;

// 租户Id
@property (class, nonatomic, assign, readonly) uint64_t tenantId;

// 自定义用户uid
@property (class, nonatomic, strong, readonly) NSString *customUid;

/*!
 * @method
 * @abstract 初始化点播SDK
 * @param tenantId  租户id
 * @param customUid  用户id（使用方自己用户体系的uid）
 * @param token  点播的token信息
 * @discussion 初始化点播SDK
 */
+ (void)configTenantId:(uint64_t)tenantId customUid:(NSString *)customUid token:(NSString *)token;


@end

NS_ASSUME_NONNULL_END
