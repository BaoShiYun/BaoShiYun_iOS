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

+ (void)configTenantId:(uint64_t)tenantId customUid:(NSString *)customUid token:(NSString *)token;


@end

NS_ASSUME_NONNULL_END
