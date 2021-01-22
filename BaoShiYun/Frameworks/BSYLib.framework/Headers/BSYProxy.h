//
//  BSYProxy.h
//
//
//  Created by zddMac on 2020/11/3.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYProxy : NSProxy

///
/// By default (YES), the proxy will invoke methods in main thread,
/// otherwise will invoke methods in a asyncronous thread
///
/// ！！！
/// runInMainThread only works when this.runAsynchronously = YES
///
@property (nonatomic, assign) BOOL runInMainThread;

///
/// By default (YES), the proxy will invoke methods asynchronously,
/// otherwise will invoke methods in current synchronously
///
@property (nonatomic, assign) BOOL runAsynchronously;

/// Create a instance when you add the multicast delegate funciton to your class
+ (BSYProxy *)proxy;

- (NSInteger)delegateCount;

/// Add a delegate to the list
/// @param delegate : delegate
- (void)addDelegate:(id)delegate;

/// Remove a delegate from the list
/// @param delegate : delegate
- (void)removeDelete:(id)delegate;

/// Remove all delegates from the list
- (void)removeAllDelegates;



@end

NS_ASSUME_NONNULL_END
