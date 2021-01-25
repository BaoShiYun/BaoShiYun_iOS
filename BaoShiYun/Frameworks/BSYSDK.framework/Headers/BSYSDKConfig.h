//
//  BSYSDKConfig.h
//  BSYSDK
//
//  Created by Duane on 2020/11/4.
//

#import <Foundation/Foundation.h>
#import <BSYSDK/BSYSDKDataType.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSYDomainType) {
    BSYDomainTypeOnline = 0, // 正式环境
    BSYDomainTypePre = 1, // 预览环境
    BSYDomainTypeQA = 2, // 测试环境
    BSYDomainTypeDev = 3, // 开发环境
};

typedef void(^BSYSDKGetUidBlock)(uintID uid, NSError * _Nullable error);

@interface BSYSDKConfig : NSObject

// 运行环境
@property (class, nonatomic, assign) BSYDomainType domainType;

// 租户Id
@property (class, nonatomic, assign, readonly) uintID tenantId;

// 抱石云uid
@property (class, nonatomic, assign, readonly) uintID uid;

// 配置租户id和抱石云用户uid
+ (void)configTenantId:(uintID)tenantId uid:(uintID)uid;

// 配置租户id和自定义用户uid
+ (void)configTenantId:(uintID)tenantId customUid:(NSString *)customUid;

// 获取抱石云用户uid（异步获取，通过block返回）
+ (void)getBSYUid:(BSYSDKGetUidBlock)completion;

@end

NS_ASSUME_NONNULL_END
