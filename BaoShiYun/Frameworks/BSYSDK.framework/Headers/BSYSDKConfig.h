//
//  BSYSDKConfig.h
//  BSYSDK
//
//  Created by Duane on 2020/11/4.
//

#import <Foundation/Foundation.h>
#import <BSYSDK/BSYSDKDataType.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYSDKConfig : NSObject

// SDK版本
@property (class, nonatomic, strong, readonly) NSString *sdkVersion;

@end

NS_ASSUME_NONNULL_END
