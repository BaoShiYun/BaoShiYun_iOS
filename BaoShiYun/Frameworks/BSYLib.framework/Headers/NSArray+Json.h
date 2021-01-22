//
//  NSArray+Json.h
//  BasicFrameworks
//
//  Created by duane on 2018/9/24.
//  Copyright © 2018年 duane. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Json)

- (NSString *)toJsonString;
- (NSMutableString *)toMutableJsonString;

@end

NS_ASSUME_NONNULL_END
