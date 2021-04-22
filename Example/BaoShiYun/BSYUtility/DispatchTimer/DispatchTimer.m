//
//  DispatchTimer.m
//  BSYLib
//
//  Created by Duane on 2020/11/3.
//

#import "DispatchTimer.h"

@interface DispatchTimer ()

@property (strong, nonatomic) dispatch_source_t timer;

@end

@implementation DispatchTimer

+ (DispatchTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     repeats:(BOOL)repeats
                                       queue:(dispatch_queue_t)queue
                                       block:(void (^)(void))block {
    DispatchTimer *timer = [[DispatchTimer alloc] initWithInterval:interval
                                                 repeats:repeats
                                                   queue:queue
                                                   block:block];
    return timer;
}

- (instancetype)initWithInterval:(NSTimeInterval)interval
                         repeats:(BOOL)repeats
                           queue:(dispatch_queue_t)queue
                           block:(void (^)(void))block {
    self = [super init];
    if (self) {
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
        __weak typeof(self)wSelf = self;
        dispatch_source_set_event_handler(self.timer, ^{
            __strong typeof(wSelf)sStrong = wSelf;
            if (!repeats) {
                [sStrong invalidate];
            }
            block();
        });
        dispatch_resume(self.timer);
    }
    return self;
}

- (void)dealloc {
    [self invalidate];
}

- (BOOL)isValidate
{
    if(self.timer)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)invalidate {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

@end
