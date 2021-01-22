//
//  BSYLiveDataTokenManager.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveDataTokenManager : NSObject

@property (nonatomic, strong, readonly)NSString *liveToken;


+ (instancetype)sharedInstance;

- (void)setLiveToken:(NSString * __nullable)liveToken;

@end

NS_ASSUME_NONNULL_END
