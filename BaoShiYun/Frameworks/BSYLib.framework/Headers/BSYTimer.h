//
//  BSYTimer.h
//  BSYLib
//
//  Created by Duane on 2020/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYTimer : NSObject

+ (BSYTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     repeats:(BOOL)repeats
                                       queue:(dispatch_queue_t)queue
                                       block:(void (^)(void))block;
- (BOOL)isValidate;
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
