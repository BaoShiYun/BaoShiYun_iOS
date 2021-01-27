//
//  BSYBasicUtility.h
//  BSYLib
//
//  Created by Duane on 2020/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYBasicUtility : NSObject

+ (NSString *)getAppCurrentVersion;
+ (NSString *)getAppBundleIdentifier;

+ (NSString *)platform;
+ (NSString *)getUniqueIdentifier;
+ (float)systemVersion;

+ (NSBundle *)libraryBundle;

+ (NSString *)mainBundleDirectory;
+ (NSString *)documentDirectory;
+ (NSString *)cachesDirectory;

+ (NSString *)typeFileExtensionWithName:(NSString *)name;

+ (NSString *)fileSizeToString:(NSUInteger)llBytes;

@end

NS_ASSUME_NONNULL_END
