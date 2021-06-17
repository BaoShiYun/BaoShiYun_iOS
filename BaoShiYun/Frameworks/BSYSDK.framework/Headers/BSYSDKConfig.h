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

@interface BSYSDKConfig : NSObject

// 运行环境
@property (class, nonatomic, assign) BSYDomainType domainType;

// SDK版本
@property (class, nonatomic, strong, readonly) NSString *sdkVersion;

@end

NS_ASSUME_NONNULL_END
