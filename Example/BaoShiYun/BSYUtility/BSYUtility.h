//
//  BSYUtility.h
//  BaoShiYun
//
//  Created by zddMac on 2021/3/24.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYUtility : NSObject

+ (UIEdgeInsets)iphoneSafeArea;
+ (NSString *)mainBundleDirectory;
+ (NSString *)fileSizeToString:(NSUInteger)llBytes;

@end

NS_ASSUME_NONNULL_END
