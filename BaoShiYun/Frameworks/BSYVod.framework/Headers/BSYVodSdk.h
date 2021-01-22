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

+ (void)initToken:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
